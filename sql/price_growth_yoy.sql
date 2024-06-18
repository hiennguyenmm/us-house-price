with prebase as (
    select
        date_trunc('year', time) AS year,
        region,
        mean(price) AS avg_sale_price
    from
        us_house_price
    group by
        1,
        2
),
base as (
    select
        year,
        region,
        (
            avg_sale_price * 1.00 / lag(avg_sale_price) over (
                partition by region
                order by
                    year asc
            )
        ) - 1 AS price_growth
    from
        prebase
)
select
    *
from
    base
where
    price_growth is not null