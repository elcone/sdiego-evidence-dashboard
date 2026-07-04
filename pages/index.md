---
title: Resultados de la Privada
---

```sql saldo_bajio
select
  sum(saldo) as saldo
from sdiego.saldo_bajio
where periodo = (select max(periodo) from sdiego.saldo_bajio)
```

```sql saldos_por_casa
select
  casa::int::varchar as casa,
  saldo
from sdiego.saldos_por_casa
where saldo <> 0
order by casa
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

```sql selector_mes_gastos
select distinct mes
from sdiego.gastos
```

```sql gastos
select
  tipo_gasto,
  sum(importe) as importe
from sdiego.gastos
where mes = '${inputs.selector_mes_gastos.value}'
group by tipo_gasto
```

## BanBajío

<BigValue
  data={saldo_bajio}
  value=saldo
  fmt='$#,##0.00'
/>

## Saldos por casa

<DataTable
  data={saldos_por_casa}
  totalRow=true
>
  <Column id=casa />
  <Column id=saldo fmt='$#,##0.00' />
</DataTable>

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
/>

Selected: {inputs.selector_mes_gastos.value}

<DataTable
  data={gastos}
  totalRow=true
>
  <Column id=tipo_gasto />
  <Column id=importe fmt='$#,##0.00' />
</DataTable>
