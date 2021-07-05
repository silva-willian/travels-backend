# Introdução 
Travel Service

# Setup do ambiente
Instale os seguintes itens em sua maquina:
1.	Instalar a versão 3.1 do dotnet core
2.  Instalar o cli do Entity Framework
3.	Instalar o Docker e docker compose

# Execução local
1. Abra o prompt de comando
2. Acesse a pasta raiz do projeto
3. Rode o comando: docker-compose -f devops/application/local/docker-compose.yaml up -d
4. Rode o comando: dotnet restore
5. Rode o comando: dotnet build
6. Rode o comando: dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover
7. Acesse a pasta Api/
8. Rode o comando: dotnet ef database update
9. Rode o comando: dotnet run
10. Abra o navegador e acesse o endereço http://localhost:5000/swagger

# Execução da aplicação com Docker
1. Abra o prompt de comando
2. Acesse a pasta raiz do projeto
3. Rode o comando: docker-compose -f devops/application/local/docker-compose.yaml up -d
4. Rode o comando: docker build -t app -f devops/application/build/Dockerfile .
5. Rode o comando: docker run --rm -p 5000:80 app
6. Abra o navegador e acesse o endereço http://localhost:5000/swagger

# Execução dos testes unitarios com Docker
1. Abra o prompt de comando
2. Acesse a pasta raiz do projeto
4. Rode o comando: docker volume create app-volume
5. Rode o comando: docker build -t app-test -f devops/application/test/Dockerfile .
6. Rode o comando: docker run --rm --mount source=test-volume,target=/app app-test
7. Rode o comando: docker build -t app-sonar -f devops/application/sonar/Dockerfile .
8. Rode o comando: docker run \
                --rm \
                --mount source=app-volume,target=/app \
                -e VERSION="1.0.0" \
                -e PROJECT_NAME="travels-backend" \
                -e SONAR_HOST="your_host" \
                -e SONAR_TOKEN="your_token" \
                app-sonar

# Contribuidores
- Willian da Silva

