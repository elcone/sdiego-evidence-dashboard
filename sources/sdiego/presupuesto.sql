select
  periodo,
  categoria,
  importe,
  ejercido,
  diferencia
from privada_san_diego.presupuesto
where periodo is not null
