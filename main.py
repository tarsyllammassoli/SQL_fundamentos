import sqlite3

conexao = sqlite3.connect("banco.db")
cursor = conexao.cursor()

cursor.execute("""CREATE TABLE IF NOT EXISTS contas_bancarias (
               id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
               titular TEXT NOT NULL,
               saldo FLOAT NOT NULL,
               cpf TEXT NOT NULL UNIQUE
               )""")

conexao.execute("""INSERT INTO contas_bancarias 
                (titular, saldo, cpf) VALUES 
                ('Pedro', 500, '13780196800')""")

conexao.commit()