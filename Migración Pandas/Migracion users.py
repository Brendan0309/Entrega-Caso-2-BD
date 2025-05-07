import pandas as pd
import pymysql
import pyodbc
from datetime import datetime

class DatabaseMigrator:
    def __init__(self):
        self.mysql_conn = None
        self.sqlserver_conn = None
    
    def connect_databases(self):
        """Establece conexiones con ambas bases de datos"""
        try:
            # Conexión MySQL
            self.mysql_conn = pymysql.connect(
                host='localhost',
                user='root',
                password='123456',
                database='PaymentAsistant'
            )
            
            # Conexión SQL Server
            self.sqlserver_conn = pyodbc.connect(
                r'DRIVER={ODBC Driver 17 for SQL Server};'
                r'SERVER=DESKTOP-SDG81AJ\SQLEXPRESS;'
                r'DATABASE=caipiDb;'
                r'Trusted_Connection=yes;'
            )
            print("✅ Conexiones establecidas correctamente")
        except Exception as e:
            print(f"❌ Error al conectar a las bases de datos: {e}")
            raise

    def migrate_users_data(self):
        """Migra los datos de users desde MySQL a SQL Server"""
        try:
            # 1. Extraer datos de MySQL
            users_data = self._extract_users_data()
            
            # 2. Obtener el máximo ID actual en SQL Server
            max_id = self._get_max_users_id()
            print(f"ℹ️ Máximo ID actual en destino: {max_id}")
            
            # 3. Insertar datos en SQL Server
            self._insert_users_data(users_data)
            
            print(f"✅ Migración exitosa. {len(users_data)} users migrados")
        except Exception as e:
            print(f"❌ Error durante la migración: {e}")
            raise

    def _extract_users_data(self):
        """Extrae los datos de users desde MySQL"""
        query = """
            SELECT userid, password, enabled, personId 
            FROM Payment_Users
        """
        return pd.read_sql(query, self.mysql_conn)

    def _get_max_users_id(self):
        """Obtiene el máximo ID de users en la base de datos destino"""
        with self.sqlserver_conn.cursor() as cursor:
            cursor.execute("SELECT MAX(userId) FROM caipiDb.dbo.caipi_Users")
            return cursor.fetchone()[0] or 0

    def _insert_users_data(self, users_df):
        """Inserta los datos de users en SQL Server"""
        with self.sqlserver_conn.cursor() as cursor:
            for _, row in users_df.iterrows():
                cursor.execute("""
                    INSERT INTO caipiDb.dbo.caipi_Users 
                    (password, enabled, personId)
                    VALUES (?, ?, ?)
                """, row['password'], row['enabled'], row['personId'])
            self.sqlserver_conn.commit()

    def close_connections(self):
        """Cierra todas las conexiones a bases de datos"""
        try:
            if self.mysql_conn:
                self.mysql_conn.close()
            if self.sqlserver_conn:
                self.sqlserver_conn.close()
            print("✅ Conexiones cerradas correctamente")
        except Exception as e:
            print(f"⚠️ Error al cerrar conexiones: {e}")

def main():
    migrator = DatabaseMigrator()
    
    try:
        migrator.connect_databases()
        migrator.migrate_users_data()
    except Exception as e:
        print(f"🔴 Migración fallida: {e}")
    finally:
        migrator.close_connections()

if __name__ == "__main__":
    main()
