---
title: Gastos Mensuales
---

```sql saldo_bajio
select
  sum(saldo) as saldo
from sdiego.saldo_bajio
where periodo = (select max(periodo) from sdiego.saldo_bajio)
```

```sql gastos_del_mes
select
  sum(importe) as importe
from sdiego.gastos
where mes = '${inputs.selector_mes_gastos.value}'
```

```sql ingresos_vs_gastos
with movimiento as (
  select
    'Ingreso' as movimiento,
    periodo,
    mes,
    sum(importe) as importe
  from sdiego.ingresos
  group by periodo, mes

  union all

  select
    'Gasto' as movimiento,
    periodo,
    mes,
    sum(importe) as importe
  from sdiego.gastos
  group by periodo, mes

)

select *
from movimiento
order by periodo
```

```sql tendencia_gastos
select
  periodo,
  mes,
  tipo_gasto,
  sum(importe) as importe
from sdiego.gastos
group by periodo, mes, tipo_gasto
order by periodo
```

```sql selector_mes_gastos
select distinct mes
from sdiego.gastos
order by mes
```

```sql gastos
select
  tipo_gasto,
  sum(importe) as importe
from sdiego.gastos
where mes = '${inputs.selector_mes_gastos.value}'
group by tipo_gasto
order by importe desc
```

## Bancos

<BigValue
  data={saldo_bajio}
  value=saldo
  fmt='$#,##0.00'
  title='Saldo BanBajío'
/>

## Ingresos vs Gastos

<BarChart
  data={ingresos_vs_gastos}
  x=mes
  y=importe
  series=movimiento
  type=grouped
  yFmt=usd
  sort=false
/>

## Gastos

<Dropdown
  data={selector_mes_gastos}
  name=selector_mes_gastos
  value=mes
  title="Mes"
  noDefault=true
/>

<br />

<BigValue
  data={gastos_del_mes}
  value=importe
  fmt='$#,##0.00'
  title='Gastos del Mes'
/>

<DataTable
  data={gastos}
  totalRow=true
  rows=all
>
  <Column id=tipo_gasto />
  <Column id=importe fmt='$#,##0.00' />
</DataTable>

<LineChart
  data={tendencia_gastos}
  x=mes
  y=importe
  series=tipo_gasto
  sort=false
/>
