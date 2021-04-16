//Requerimientos (¿qué hace mi sistema?):
/* Saber el precio de una prenda individual
 * Saber el tipo de prenda
 * Registrar una venta de una prenda
 * Poder consultar las ganancias totales de cierto dia
 */

class Prenda{
	
	var tipoPrenda
	var precioBase
	var estado

	constructor(_tipoPrenda, _precioBase, _estado){
		tipoPrenda = _tipoPrenda
		precioBase = _precioBase
		estado = _estado
	}
	
	
	method tipoPrenda() = tipoPrenda
	
	method precio() = estado.precio(precioBase) 
}

object nueva{
	method precio(precioBase) = precioBase
}

object liquidacion{
	method precio(precioBase) = precioBase / 2
}

class Promocion{
	var valorDescuento
	
	constructor(_valorDescuento){
		valorDescuento = _valorDescuento
	}
	
	method precio(precioBase) = precioBase - valorDescuento
}

object caja{
	
	const ventas = []
	
	method registrarVenta(prendas, fecha, tipoDeVenta){
		ventas.add(new Venta(prendas, fecha, tipoDeVenta))
	}
	
	method ventasDelDia(fecha) = ventas.filter({unaVenta => unaVenta.fecha() == fecha}) //me fijo cuales son las ventas del dia
	
	method gananciaDelDia(fecha) = self.ventasDelDia(fecha).sum({unaVenta => unaVenta.total()}) //con las ventas del dia, sumo el total de cada venta
}

class Venta{
	const prendas = [] //ingreso instancias de prendas
	var fecha
	var tipoDeVenta
	
	constructor(_prendas, _fecha, _tipoDeVenta){
		prendas = _prendas
		fecha = _fecha
		tipoDeVenta = _tipoDeVenta
	}
	
	
	method totalPrendas() = prendas.sum({unaPrenda => unaPrenda.precio()})
	
	method total() = tipoDeVenta.total(self.totalPrendas())
	
	method fecha() = fecha
		

}

class Tarjeta{
	var cuotas
	
	const coeficiente = 0.5 //inventado (?
	
	constructor(_cuotas){ 
		cuotas = _cuotas
	}
	
	method total(totalPrendas) = totalPrendas + self.recargo(totalPrendas)
	
	method recargo(totalPrendas) = cuotas * coeficiente + 0.01 * totalPrendas
	
	
	
}

object efectivo{
	method total(totalPrendas) = totalPrendas
}


//ejemplo: 
//caja.registrarVenta([new Prenda("pantalon", 100, nueva), new Prenda("camisaki", 50, new Promocion(10))], 10, new Tarjeta(2))
//caja.gananciaDelDia(10)
//142.4

//no llegue a hacer tests :(


