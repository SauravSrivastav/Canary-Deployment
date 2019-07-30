FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 5000
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["HCLPaasCoe.csproj", ""]
RUN dotnet restore "HCLPaasCoe.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "HCLPaasCoe.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "HCLPaasCoe.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HCLPaasCoe.dll"]
