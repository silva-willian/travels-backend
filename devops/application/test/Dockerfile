FROM mcr.microsoft.com/dotnet/core/sdk:3.1

WORKDIR /app

COPY . .

CMD dotnet restore && \
    dotnet build && \
    dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover /p:ExcludeByFile="**/Models/%2c**/Migrations/%2c**/Enums/%2c**/Migrations/%2c**/DbContexts/%2c**/Entities/%2c/devops/%2c**/Program.cs%2c**/Startup.cs"