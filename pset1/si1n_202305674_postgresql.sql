--Alterando banco de dados uvv para o postgres.
ALTER DATABASE  uvv  OWNER TO  postgres;

--Apagar banco de dados,schema e usuário já existentes. 
DROP DATABASE IF EXISTS uvv;
DROP SCHEMA IF EXISTS   public CASCADE;
DROP SCHEMA IF EXISTS lojas;
DROP USER IF EXISTS     mateus_sarmento;

-- Criando usuário mateus_sarmento.
CREATE USER mateus_sarmento WITH
CREATEDB
CREATEROLE
ENCRYPTED PASSWORD '123';

--Conectando ao usuário mateus_sarmento.
\c 'postgresql://mateus_sarmento:123@localhost/postgres'
;

--Criando bando de dados uvv.
CREATE DATABASE uvv WITH
OWNER             ='mateus_sarmento'
TEMPLATE          = template0
ENCODING          = UTF8
LC_COLLATE        = "pt_BR.UTF-8"
LC_CTYPE          = "pt_BR.UTF-8"
ALLOW_CONNECTIONS = true;

--Conectando o BD uvv.
\c uvv

COMMENT ON DATABASE uvv IS 'Banco da dados das lojas uvv';

--Criando SCHEMA lojas com a autorização do usuário.
CREATE SCHEMA lojas 
AUTHORIZATION mateus_sarmento;

SET SEARCH_PATH TO lojas, "$USER", public;

--Definindo SCHEMA lojas como padrão.
ALTER USER  mateus_sarmento
SET SEARCH_PATH TO lojas, "$USER", public;

--Criando tabela produtos.
CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

--Adicionando comentarios as tabelas e colunas.

COMMENT ON TABLE produtos IS 'Tabela com os dados dos produtos.';
COMMENT ON COLUMN produtos.produto_id IS 'Coluna com o ID dos produtos.';
COMMENT ON COLUMN produtos.nome IS 'Coluna com o nome dos produtos.';
COMMENT ON COLUMN produtos.preco_unitario IS 'Coluna com o preço unitário dos produtos.';
COMMENT ON COLUMN produtos.detalhes IS 'Coluna com os detalhes dos produtos.';
COMMENT ON COLUMN produtos.imagem IS 'Coluna com as imagens dos produtos.';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Coluna com ID de mídia da imagem.';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Coluna com os tipos de arquivos das imagens.';
COMMENT ON COLUMN produtos.imagem_charset IS 'Coluna com o charset das imagens.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Coluna com a data da ultima atualização da imagem do produto.';

--Criando tabela lojas.
CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

--Adicionando comentarios as tabelas e colunas.

COMMENT ON TABLE lojas IS 'Tabela com dados das lojas.';
COMMENT ON COLUMN lojas.loja_id IS 'Coluna com o ID das lojas.';
COMMENT ON COLUMN lojas.nome IS 'Coluna com os nomes das lojas';
COMMENT ON COLUMN lojas.endereco_web IS 'Coluna com os dados do endereço web da loja.';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Coluna com dados do endereço físico da loja.';
COMMENT ON COLUMN lojas.latitude IS 'Coluna com dados da latitude da loja.';
COMMENT ON COLUMN lojas.longitude IS 'Coluna com dados da longitude da loja.';
COMMENT ON COLUMN lojas.logo IS 'Coluna com a logo da loja.';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Coluna com ID da logo.';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Coluna com o arquivo da logo.';
COMMENT ON COLUMN lojas.logo_charset IS 'Coluna com o charset da logo.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Coluna contendo a data da ultima atualização da logo.';

--Criando tabela estoques.
CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

--Adicionando comentarios as tabelas e colunas.

COMMENT ON TABLE estoques IS 'Tabela com os estoques das lojas.';
COMMENT ON COLUMN estoques.estoque_id IS 'Coluna com ID dos estoques.';
COMMENT ON COLUMN estoques.loja_id IS 'Coluna com o ID  das lojas.';
COMMENT ON COLUMN estoques.produto_id IS 'Coluna com o ID dos produtos.';
COMMENT ON COLUMN estoques.quantidade IS 'Coluna que mostra dados da quantidade de estoque.';

--Criando tabela clientes.
CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

--Adicionando comentarios as tabelas e colunas.

COMMENT ON TABLE clientes IS 'Tabela com dados dos clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Coluna PK da tabela, com o ID dos clientes.';
COMMENT ON COLUMN clientes.email IS 'Coluna com os emails dos clientes.';
COMMENT ON COLUMN clientes.nome IS 'Coluna com os nomes dos clientes.';
COMMENT ON COLUMN clientes.telefone1 IS 'Coluna com o número de telefone dos clientes.';
COMMENT ON COLUMN clientes.telefone2 IS 'Coluna com o  segundo número de telefone dos clientes.';
COMMENT ON COLUMN clientes.telefone3 IS 'Coluna com o terceiro número de telefone dos clientes.';

--Criando tabela envios.
CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

--Adicionando comentarios as tabelas e colunas.

COMMENT ON TABLE envios IS 'Tabela com os dados dos envios das lojas  para os clientes.';
COMMENT ON COLUMN envios.envio_id IS 'Coluna com ID do envio da loja.';
COMMENT ON COLUMN envios.loja_id IS 'Coluna com o ID das lojas.';
COMMENT ON COLUMN envios.cliente_id IS 'Coluna que é a PK da tabela com o ID dos clientes da loja.';
COMMENT ON COLUMN envios.endereco_entrega IS 'Coluna com os dados dos endereços que os produtos devem ser entregues.';
COMMENT ON COLUMN envios.status IS 'Coluna com os status dos envios.';

--Criando tabela pedidos.
CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

--Adicionando comentarios as tabelas e colunas.

COMMENT ON TABLE pedidos IS 'Tabela com os dados dos pedidos dos clientes e das lojas.';
COMMENT ON COLUMN pedidos.pedido_id IS 'PK da coluna identifica o ID do produto.';
COMMENT ON COLUMN pedidos.data_hora IS 'Coluna com a data e hora do pedido.';
COMMENT ON COLUMN pedidos.cliente_id IS 'Coluna que é PK da tabela com o ID dos clientes.';
COMMENT ON COLUMN pedidos.status IS 'Coluna do status do pedido.';
COMMENT ON COLUMN pedidos.loja_id IS 'Coluna com o ID das lojas.';

--Criando tabela pedidos_itens.
CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

--Adicionando comentarios as tabelas e colunas.

COMMENT ON TABLE pedidos_itens IS 'Tabela com os pedidos dos itens.';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'PK da coluna que  identifica o ID do pedido.';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Coluna com o ID dos produtos.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Coluna com os números da linha do pedido.';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Coluna com os preços dos pedidos.';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Coluna com a quantidade de itens pedidos.';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Coluna com ID do envio da loja.';

--Adicionando a foreign key produto_id a tabela estoques.
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando foreign key produto_id a tabela pedidos_itens.
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando foreign key loja_id a tabela pedidos.
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando a foreign key loja_id a tabela envios.
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando foreign key loja_id para a tabela estoque.
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando foreign key cliente_id a tabela pedidos.
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando foreing key cliente_id a tabela envios.
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando foreing key envio_id a tabela pedidos_itens.
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionando foreign key pedido_id a tabela pedido_itens.
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Realizando as Checks.

ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK (
       status in ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSO','ENVIADO')
);

ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK (
       status in ('CRIADO','ENVIADO','TRANSITO','ENTREGUE')
);

ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas
CHECK (
      (endereco_web is not null) or (endereco_fisico is not null)
);

ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK (
       preco_unitario >= 0
);
