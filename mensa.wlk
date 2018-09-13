object paquete {
	var pago = false
	var destino = puenteDeBrooklyn
	method pagado (estado) {
		pago = estado
	}
	method setDestino (_destino) {
		destino =  _destino
	}
	method pagado() = pago
	method destino() = destino
	
}



object puenteDeBrooklyn{
	method permite(mensajero){
		return (mensajero.peso() <= 1000)
	}
}

object laMatrix{	
	method permite(mensajero) {
		return mensajero.puedeLlamar()
	}
}

object roberto{
	var	peso = 90
	var trasporte = bici
	method puedeLlamar() = false
	method peso() = peso + trasporte.peso()
	method cambiarT(nuevoTransporte){
		trasporte = nuevoTransporte
	}
}

object bici {	
	method peso() = 0
}
object mack {
	var acoplados = 1
	method acoplados(cant){
		acoplados = cant
	}
	method peso() = acoplados*500	
}



object chuck{
	var	peso = 900
	method puedeLlamar() = true
	method peso() = peso
}

object neo{
	var puedeLlamar = false
	method 	tieneCredito(credito){
		puedeLlamar = credito
	}	
	method puedeLlamar() = puedeLlamar
	method peso() = 0
}

object trasportar {
	method permitido (mensajero , paquete){
		var destino = paquete.destino()
		return (destino.permite(mensajero) && paquete.pagado() ) 
	}
}

object fedex {
	var mensajeros = [chuck, neo , roberto]
	method mensajeros() = mensajeros
	method contratarM (mensajero){
		mensajeros.add(mensajero)
	}
	method despedirM (mensajero){
		mensajeros.remove(mensajero)
	}
	method despedirTodos(){
		mensajeros = []
	}
	method esGrande() {
		return (mensajeros.size() > 2 )
	}
	
	method puedeEntregar(paquete) {
		 var mensj = mensajeros.first()
		 return (trasportar.permitido(mensj, paquete))
	}
	
	method pesoDeUltimo () {
		return (mensajeros.last()).peso()
	}
}


object empresaParaEnvio {
	var envios = [ ]
	method disponible(empresa, paquete) {
		return (empresa.mensajeros().any({ unMensaje => trasportar.permitido(unMensaje,paquete) }))		
	}
	
	method esFacil (empresa,paquete) {
		return (empresa.mensajeros().all({ unMensaje => trasportar.permitido(unMensaje,paquete) }))
	}
	
	method candidatos (empresa , paquete ) {
		return (empresa.mensajeros().filter({ unMensaje => trasportar.permitido(unMensaje,paquete) })) 
	}
	
	method mensajerosConSobrepeso(empresa){
		var pesos = empresa.mensajeros().peso()
		var cantidad = empresa.mensajeros().size()
		var suma = pesos.sum()
		
		return (suma / cantidad)
	}
	
	method enviarPaquete (empresa , paquete){
		if( self.disponible(empresa,paquete) ){
			envios.add(paquete)
			console.println("Enviado")
			return true 			
		}
		console.println("No se pudo enviar , no hay mensajeros para esta tarea")
		return false
	}
	
}

