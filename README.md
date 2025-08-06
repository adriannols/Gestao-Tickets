# Gestão de Tickets 🎫

Sistema desktop desenvolvido em **Delphi** com **PostgreSQL**, voltado para o controle de entrega de tickets por funcionários. O sistema permite o cadastro, edição, listagem e relatório de tickets entregues por colaborador.

## ⚙️ Funcionalidades

- Cadastro de funcionários (ativos/inativos)  
- Registro de tickets entregues (quantidade, data e responsável)  
- Geração de relatórios de entrega  
- Validação de CPF  
- Controles de data com `TDateTimePicker`  
- Uso de componentes `FireDAC` para integração com PostgreSQL  

## 🗃️ Banco de Dados

O banco de dados utilizado é **PostgreSQL**, e o script de criação da estrutura está disponível na pasta `BD` com o nome `script_BD.sql`.

### Principais tabelas:

- `funcionarios`
- `tickets`

## 📁 Estrutura do projeto
Tickets.dpr — Arquivo principal do projeto
Tickets.dproj — Arquivo de configuração do projeto
uDataModule.pas / .dfm — Módulo de dados com conexões e queries
uFuncoes.pas — Funções auxiliares (ex: validação de CPF)
uovF_GestaoFuncionario.pas / .dfm — Tela de cadastro de funcionários
uovF_GestaoTickets.pas / .dfm — Tela de registro de tickets
uovF_RelatorioTickets.pas / .dfm — Tela de geração de relatórios
uovF_Principal.pas / .dfm — Tela principal do sistema

## 🛠️ Tecnologias Utilizadas

Delphi (Embarcadero RAD Studio)
PostgreSQL
FireDAC
Git para controle de versão

## 🚀 Como executar

Clone o repositório: 
git clone https://github.com/adriannols/Gestao-Tickets.git
Abra o projeto .dpr no Delphi
Configure a conexão com o banco no DataModule
Execute o projeto e aproveite!

## ✅ Requisitos

Delphi (versão compatível com FireDAC)
PostgreSQL
Git (opcional para versionamento)
