class Pirata {
  const inventario = []
  
  method nivelEbriedad(){}
  method dinero(){}
  method añadirObjetos(unaListaDeObjetos) {
    inventario.addAll(unaListaDeObjetos)
  }
  method inventario() = inventario  
  method esUtil(unaMision) = unaMision.esUtil(self) 
  
}

class Barco {
  const tripulacion = []
  method capacidad() = 0 
  method tripulacion()= tripulacion
  method agregarPirataSiSirve(unPirata, unaMision) {
    if(tripulacion.size()<self.capacidad() and unPirata.esUtil(unaMision)){
      tripulacion.add(unPirata)
    }
  }
  method cambiarMisionA(unaMision) {
    tripulacion.filter({c=>c.esUtil(unaMision)})
  }
}

class Mision {
  
  method tieneSuficienteTripulacion(unBarco) = unBarco.tripulacion().size() >= unBarco.capacidad()*0.90

}

object brujula {}
object mapa {}
object botellaDeGrogXD {}

class BusquedaDelTesoro inherits Mision {
  method esUtil(unPirata) = 
  unPirata.inventario().contains(brujula) or
  unPirata.inventario().contains(mapa) or
  unPirata.inventario().contains(botellaDeGrogXD) 
  
}

class ConvertirseEnLeyenda inherits Mision {
  var objeto = null
  
  method establecerItemObligatorio(unItem) {
    objeto = unItem  
  }
  method esUtil(unPirata) = unPirata.inventario().size()>=10 
}

class Saqueo inherits Mision {
  var dinero = 0

  method esUtil(unPirata) = unPirata.dinero() < dinero
  method establecerCantidadDinero(unaCantidad){
    dinero = unaCantidad
  }

}