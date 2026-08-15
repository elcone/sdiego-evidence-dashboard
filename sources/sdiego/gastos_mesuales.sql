SELECT
    periodo,
    strftime(periodo, '%Y-%m-%d') as mes,
    tipo_gasto,
    importe,
    importe_periodo_anterior,
    importe_delta,
    porc_delta
FROM gold.gastos_mensuales
