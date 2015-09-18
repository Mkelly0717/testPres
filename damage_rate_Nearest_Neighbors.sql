with neighbors as 
(
select l1.loc, count(1), round(sum(l2.yield)/count(1)*100,2) as yield
from mak_damage_rate l1, mak_damage_rate l2
where l1.loc <> l2.loc
  and l1.u_3digitzip=l2.u_3digitzip
  and l1.yield is not null
  and l2.yield is not null
  and l1.yield > 0
  and l2.yield > 0
group by l1.loc
order by l1.loc asc
)
select dr.loc
      ,round(dr.yield*100,2)as plant_yield
      ,n.yield as neighbor_yield 
      ,round(dr.yield*100,2) - n.yield  as DeltaYield
from mak_damage_rate dr, neighbors n
where round(dr.yield*100,2) > 0 and round(dr.yield*100,2) < 100
  and n.yield > 0 and n.yield < 100
  and dr.loc=n.loc(+)
  and trim(n.loc) is not null