-- Fråga 2
 -- Lista antalet produkter per kategori. Listning ska innehålla kategori-namn och antalet produkter

select Category.name as 'Category', count(ItemCategory.id) as ItemCount from Category
left join ItemCategory on Category.id = ItemCategory.category_id
group by Category.name
order by ItemCount desc;