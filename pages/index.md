---
title: Privada San Diego
---

## Ingresos

```sql ingresos
select
  strftime(last_day(periodo), '%Y-%m') as periodo,
  sum(pagos) as pagos,
  sum(importe_recaudado) as importe_recaudado
from sdiego.cuotas
where periodo <= current_date
group by periodo
order by periodo
```

<BarChart
  data={ingresos}
  x=periodo
  y=importe_recaudado
  yFmt=usd
  sort=false
/>

<DataTable
  data={ingresos}
  totalRow=true
>
  <Column id=periodo />
  <Column id=pagos fmt=usd />
  <Column id=importe_recaudado fmt=usd />
</DataTable>

## Deudores

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
where saldo > 0
```

```sql saldo_mensual
select
  strftime(periodo, '%Y-%m') as periodo,
  sum(saldo) as saldo
from sdiego.cuotas
where saldo > 0 and periodo <= current_date
group by periodo
order by periodo
```

<BigValue
  data={resumen}
  value=saldo
  fmt=usd
/>

<BigValue
  data={resumen}
  value=casas
/>

<BarChart
  data={saldo_mensual}
  x=periodo
  y=saldo
  yFmt=usd
  sort=false
/>

## Gastos

### Presupuesto vs Ejercido

```sql presupuesto
select
  strftime(periodo, '%Y-%m') as periodo,
  sum(importe) as importe,
  sum(ejercido) as ejercido
from sdiego.presupuesto
group by periodo
order by periodo
```

<BarChart
  data={presupuesto}
  x=periodo
  y={['importe', 'ejercido']}
  yFmt=usd
  sort=false
  type=grouped
/>

### Gastos por concepto

```sql gastos_por_categoria
select
  strftime(periodo, '%Y-%m') as periodo,
  categoria,
  sum(ejercido) as total_ejercido,
  sum(importe) as total_presupuesto
from sdiego.presupuesto
where periodo <= current_date
group by periodo, categoria
order by periodo, "total_ejercido" desc
```

<DataTable
  data={gastos_por_categoria}
  groupBy=periodo
  subtotals=true
  totalRow=true
  groupsOpen=false
>
  <Column id=periodo />
  <Column id=categoria totalAgg=countDistinct />
  <Column id=total_ejercido totalFmt=usd fmt=usd />
  <Column id=total_presupuesto totalFmt=usd fmt=usd />
</DataTable>
