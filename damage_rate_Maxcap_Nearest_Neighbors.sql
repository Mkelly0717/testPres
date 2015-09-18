with neighbors as 
(
select l1.loc, count(1), round(sum(l2.maxcap)/count(1)) as maxcap
from mak_damage_rate l1, mak_damage_rate l2
where l1.loc <> l2.loc
  and l1.u_3digitzip=l2.u_3digitzip
  and l1.maxcap is not null
  and l2.maxcap is not null
  and l1.maxcap > 0
  and l2.maxcap > 0
group by l1.loc
order by l1.loc asc
)
select dr.loc
      ,round(dr.yield*100,2) as yield
      ,dr.maxcap as plant_maxcap
      ,n.maxcap as neighbor_maxcap 
      ,dr.maxcap - n.maxcap  as Deltamaxcap
from mak_damage_rate dr, neighbors n
where dr.maxcap > 0
  and n.maxcap > 0 
  and dr.yield > 0 and round(dr.yield*100,2) < 100
  and dr.loc=n.loc(+)
  and trim(n.loc) is not null