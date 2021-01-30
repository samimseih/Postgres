drop table larget;
create table larget ( id bigint, id2 bigint , id3 bigint , id4 bigint );
alter table larget set ( autovacuum_enabled=off );
create index i1 on larget ( id,id2,id3,id4 );
create index i2 on larget ( id,id2,id3,id4 );
create index i3 on larget ( id,id2,id3,id4 );
create index i4 on larget ( id,id2,id3,id4 );
create index i5 on larget ( id,id2,id3,id4 );
create index i6 on larget ( id,id2,id3,id4 );
create index i7 on larget ( id,id2,id3,id4 );
create index i8 on larget ( id,id2,id3,id4 );
create index i9 on larget ( id,id2,id3,id4 );
create index i10 on larget ( id,id2,id3,id4 );
create index i11 on larget ( id,id2,id3,id4 );
create index i12 on larget ( id,id2,id3,id4 );
create index i13 on larget ( id,id2,id3,id4 );
create index i14 on larget ( id,id2,id3,id4 );
create index i15 on larget ( id,id2,id3,id4 );



CREATE OR REPLACE FUNCTION create_bloat_f(batch_size bigint default 1) RETURNS text  AS $$
DECLARE
	res text ;

BEGIN
	insert into larget select random_range(1,100000000), random_range(1,100000000), random_range(1,100000000), random_range(1,100000000) from generate_series(1,batch_size);
	delete from larget;
	select n_dead_tup::text||' dead rows , ' ||(pg_relation_size('larget')/1024/1024)::text ||'MB total table size , '||(pg_total_relation_size('larget')/1024/1024)::text ||'MB total table size with indexes' into res  from pg_stat_all_tables where relname='larget';
	return res;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE create_bloat_p(batch_size bigint default 1)  AS $$
DECLARE
  res text ;

BEGIN
  insert into larget select random_range(1,100000000), random_range(1,100000000), random_range(1,100000000), random_range(1,100000000) from generate_series(1,batch_size);
  select n_dead_tup::text||' dead rows , ' ||(pg_relation_size('larget')/1024/1024)::text ||'MB total table size , '||(pg_total_relation_size('larget')/1024/1024)::text ||'MB total table size with indexes' into res  from pg_stat_all_tables where relname='larget';
  raise notice '%', res;
  ROLLBACK;
END;
$$ LANGUAGE plpgsql;

