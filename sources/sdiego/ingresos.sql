SELECT
    periodo,
    strftime(periodo, '%Y-%m-%d') as mes,
    recibo,
    importe,
    tipo_ingreso,
    concepto_banco
FROM silver.ingresos
