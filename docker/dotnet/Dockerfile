#
#	Holt das Microsoft DotNet SDK und Erstellt ein Beispiel Programm 
#
#	Builden: docker build -t dotnetapp .
#	Aufruf : docker run -it --rm dotnetapp 
#   Im Container: dotnet out/dotnetapp.dll

FROM microsoft/dotnet
MAINTAINER Marcel Bernet <marcel.bernet@tbz.ch>

RUN apt-get update && apt-get install -y vim nano

# gleicher Name wie Applikation
WORKDIR /dotnetapp

# Applikation erstellen und compilieren
RUN dotnet new console
RUN dotnet restore 
RUN dotnet run 
RUN dotnet publish -c Release -o out
RUN dotnet out/dotnetapp.dll
