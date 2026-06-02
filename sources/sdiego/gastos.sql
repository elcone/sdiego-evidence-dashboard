select
  fecha,
  categoria,
  concepto,
  importe,
  estado
from privada_san_diego.gastos
where fecha is not null
