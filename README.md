#TTPS opción Ruby: Facultad de Informática - UNLP


##Contexto

El estudio contable **E-Vader** te ha contactado para pedirte que desarrolles una aplicación web que les
permita realizar algunas tareas que hoy por hoy llevan de forma manual, nada sistemática, en hojas de
cálculo de Open Office y papel. Como te hicieron una oferta que no podés rechazar, aceptaste de muy
buena gana realizar el desarrollo.
Están muy apurados por cambiar su forma de trabajo, y por eso te fijaron como fecha límite para tener la
aplicación el día Lunes 21 de Diciembre de 2015. Ese día esperan tener toda la funcionalidad
implementada y lista para ser usada, aunque pueden aceptar que la interfaz de usuario no sea muy linda.
A continuación tenés el resultado del análisis de requerimientos que tu Product Owner obtuvo tras algunas
reuniones con los futuros usuarios de la aplicación, depuradas a un lenguaje relativamente técnico.

## Instalación
  
  Si no tiene instalado Bundler: 

` sudo apt-get install bundler ` o `gem install bundler`
  
` bundle install `

## Ejecución

  Migraciones: `bundle exec rake db:migrate`
  
  Datos de prueba: `bundle exec rake db:setup`
  
## Testeo

  ` bundle exec rake test --verbose `

  
