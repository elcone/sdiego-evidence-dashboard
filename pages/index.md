---
title: Privada San Diego
---

```sql deudores
select
  casa,
  strftime(periodo, '%Y-%m') as cuota,
  saldo
from sdiego.cuotas
where saldo > 0
order by casa, periodo
```

```sql resumen
select
  count(distinct casa) as casas,
  sum(saldo) as saldo
from ${deudores}
```

```sql saldo_por_casa
select
  cast(casa as varchar) as casa,
  sum(saldo) as saldo
from ${deudores}
group by casa
```

## Deudores

<BigValue
  data={resumen}
  value=saldo
  fmt=usd
/>

<BigValue
  data={resumen}
  value=casas
/>

### Saldo por casa

<BarChart
  data={saldo_por_casa}
  x=casa
  y=saldo
  yFmt=usd
/>

<DataTable
  data={deudores}
  rowNumbers=true
  groupBy=casa
  subtotals=true
  totalRow=true
  groupsOpen=false
>
  <Column id=casa totalAgg=countDistinct align=left />
  <Column id=cuota totalAgg=countDistinct totalFmt='0 "cuotas"' />
  <Column id=saldo fmt=usd />
</DataTable>

### Saldo por mes

<DataTable
  data={deudores}
  rowNumbers=true
  groupBy=cuota
  subtotals=true
  totalRow=true
  groupsOpen=false
>
  <Column id=cuota totalAgg=countDistinct totalFmt='0 "cuotas"' />
  <Column id=casa totalAgg=countDistinct align=left />
  <Column id=saldo fmt=usd />
</DataTable>
