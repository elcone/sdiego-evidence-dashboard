SELECT
    fecha,
    fecha_y_hora,
    strftime(fecha, '%Y-%m-%d') as fecha_pago,
    recibo,
    casa,
    importe
FROM silver.pagos_de_casas
