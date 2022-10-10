#Indicar que obtenga el runtame y ponerle base
#Deseo que la imagen que se obtiene se agrege al interior del container(en una carpeta)
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
#Crear directorio al interior del container. Y dentro de esa carpeta se va agregar el runtime
WORKDIR /app
#Puerto
EXPOSE 80
#Descargar SDK.NET CORE
FROM mcr.microsoft.com/dotnet/sdk:6.0 as build
#copiarlo al interior del container en la carpeta
WORKDIR /src
 #Ahora agregar el proyecto, todo el codigo fuente
 COPY "MVCPrototipo.csproj" .
 #luego de copiar todas las fuentes, descargar las librerias, paquetes nugget que usa la app.
 RUN dotnet restore "MVCPrototipo.csproj"

 COPY . .

 ## AHORA CREAR PROCESO DE COMPILACION PARA GENERAR LAS DLLS
 RUN dotnet build . -c Release -o /app/build
 ## ya se tienen las dlls, ahora los archivos de publicacion, ejecutables que arrancan la ap
 FROM build AS publish
 RUN dotnet publish "MVCPrototipo.csproj" -c Release -o /app/publish

 #Agregar el runtime dentro de la carpeta de publicacion para que ejecute.
 FROM base AS final
 WORKDIR /app
 COPY --from=publish /app/publish .

 ##Indicar como el cliente se va a comunicar con esta aplicacion.
 ENTRYPOINT [ "dotnet","MVCPrototipo.dll" ]