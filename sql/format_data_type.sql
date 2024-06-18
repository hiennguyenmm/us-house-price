select
    strptime("Month of Period End" :: varchar, '%d/%m/%Y') :: datetime as time,
    "Region" AS region,
    regexp_extract("Median Sale Price", '\$(.*)K', 1) :: int AS price,
    replace("Homes Sold", '.', '') :: int AS homes_sold,
    replace("New Listings", '.', '') :: int AS new_listings,
    replace("Inventory", '.', '') :: int AS inventory,
    replace("Days on Market", '.', '') :: int AS days_on_market,
    replace(
        replace("Average Sale To List", '%', ''),
        ',',
        '.'
    ) :: float / 100 AS avg_sale_to_list
from
    data_extraction