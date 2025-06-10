class BarcoPirata {
  var mision
  const property tripulacion = []
  const capacidad

  method tripulanteTieneObjetoDelTesoro(unObjeto) = tripulacion.contains(unObjeto)
  method cantidadTripulantes() = tripulacion.size()
  method esVulnerable(unBarco) = unBarco.cantidadTripulantes()/2 >= self.cantidadTripulantes()  
  method saqueadoPor(unPirata) = unPirata.estaPasadoDeGrog()
  method estanTodosPasadosDeGrog() = tripulacion.all({c=>c.estaPasadoDeGrog()})
  method agregarPirata(unPirata){
    if(capacidad > self.cantidadTripulantes() and mision.esUtil(unPirata)){
        tripulacion.add(unPirata)
    }
  }
  method cambiarDeMision(nuevaMision){
    mision = nuevaMision
    tripulacion.removeAll(self.tripulantesNoAptos(nuevaMision))
  } 

  method tripulantesNoAptos(unaMision) = tripulacion.filter({c=>!c.esUtil(unaMision)}) 
  method anclarEnCiudad(unaCiudad) {
    tripulacion.forEach({c=>c.tomarGrog()})//revisar
    tripulacion.remove(self.tripulanteMasEbrio())
    unaCiudad.sumarHabitante()
  }
  method tripulanteMasEbrio() = tripulacion.max({c=>c.nivelDeEbriedad()})
  //method esTemible()

}

class Ciudad {
  var property habitantes
  method esVulnerable(unBarco) = habitantes*0.4 <= unBarco.cantidadTripulantes() or unBarco.estanTodosPasadosDeGrog() 
  method saqueadoPor(unPirata) = unPirata.nivelDeEbriedad() >= 90
  method sumarHabitante() {
    habitantes+=1
  }
}

class Pirata {
  var monedas
  method monedas()= monedas
  const property items = []
  var nivelDeEbriedad
  method esUtil(unaMision) {}
  method estaPasadoDeGrog() = nivelDeEbriedad >= 90 
  method nivelDeEbriedad() = nivelDeEbriedad 
  method tomarGrog(unaCantidad) {//revisar
    nivelDeEbriedad+= unaCantidad
  }
  method gastarMonedas(unaCantidad) {//revisar
    monedas -= unaCantidad
  }


}

class Mision {
  method puedeCompletarMision(unBarco) = unBarco.tieneSuficienteTripulacion()
}

class BusquedaDelTesoro inherits Mision {
    method tieneitemDelTesoro(unPirata) = unPirata.items().contains("brujula") or unPirata.items().contains("mapa") or unPirata.items().contains("botellaGrog") 
  method esUtil(unPirata) = self.tieneitemDelTesoro(unPirata) and unPirata.monedas()<= 5
  override method puedeCompletarMision(unBarco)= super(unBarco) and unBarco.tripulanteTieneObjetoDelTesoro("una llave") 
}

class Leyenda {
  const itemObligatorio
  method esUtil(unPirata) = unPirata.items().size()>=10 and unPirata.items().contains(itemObligatorio)
}

class Saqueo inherits Mision {
  const objetivo

  method esUtil(unPirata) = unPirata.monedas()<cantidadMonedas.valor() and unPirata.seAnima(self)//revisar "anima"
  override method puedeCompletarMision(unBarco) = super(unBarco) and objetivo.esVulnerable(unBarco)
}

object cantidadMonedas {
  var property valor = 10
}