select
  periodo,
  cast(casa as varchar) as casa,
  cuota,
  recargos,
  pagos,
  saldo,
  estado,
  fecha_pago,
  importe_recaudado
from privada_san_diego.cuotas
where periodo is not null
