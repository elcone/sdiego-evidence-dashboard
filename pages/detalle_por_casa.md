---
title: Detalle por Casa
---

```sql selector_casa
select distinct casa
from sdiego.saldos_por_casa
order by casa
```

```sql saldo_casa
select
  casa::int::varchar as casa,
  sum(saldo) as saldo
from sdiego.saldos_por_casa
where casa = '${inputs.selector_casa.value}'
group by casa
order by casa
```

```sql cargos
select
  fecha_vencimiento,
  '<code class=markdown>' || vencimiento ||' </code>' as vencimiento,
  '<code class=markdown>' || estado ||' </code>' as estado,
  cuota,
  recargos,
  cuota + coalesce(recargos, 0) as importe_total
from sdiego.cargos
where casa = '${inputs.selector_casa.value}'
order by periodo
```

```sql pagos
select
  fecha_pago,
  importe
from sdiego.pagos_de_casas
where casa = '${inputs.selector_casa.value}'
order by fecha
```

<Dropdown
  data={selector_casa}
  name=selector_casa
  value=casa
  title="Casa"
/>

<br>

<BigValue
  data={saldo_casa}
  value=saldo
  fmt='$#,##0.00'
/>

## Cargos

<DataTable
  data={cargos}
  totalRow=true
  rows=12
>
  <Column id=fecha_vencimiento />
  <Column id=vencimiento contentType=html />
  <Column id=estado contentType=html />
  <Column id=cuota fmt='$#,##0.00' />
  <Column id=recargos fmt='$#,##0.00' />
  <Column id=importe_total fmt='$#,##0.00' />
</DataTable>

## Pagos

<DataTable
  data={pagos}
  totalRow=true
>
  <Column id=fecha_pago />
  <Column id=importe fmt='$#,##0.00' />
</DataTable>
