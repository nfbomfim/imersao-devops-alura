# definição da imagem base: python:3.13.5-alpine3.22
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# O ponto final "." significa que estamos copiando para o diretório definido no WORKDIR
COPY requirements.txt .

# Instala as dependências do projeto
# --no-cache-dir é usado para não armazenar o cache do pip, mantendo a imagem menor
# -r requirements.txt especifica o arquivo que lista as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os arquivos do projeto (do diretório atual) para o diretório de trabalho no contêiner
COPY . .

# Expõe a porta 8000, que é a porta padrão que o uvicorn usará para rodar a aplicação
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar
# Usamos 0.0.0.0 para que a aplicação seja acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
