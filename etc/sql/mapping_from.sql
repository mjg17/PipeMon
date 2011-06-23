SELECT asr.seq_region_id, asr.name, acs.name, acs.version, COUNT( * )
  FROM assembly me
  JOIN seq_region csr   ON me.cmp_seq_region_id = csr.seq_region_id
  JOIN coord_system ccs ON csr.coord_system_id = ccs.coord_system_id
  JOIN seq_region asr   ON me.asm_seq_region_id = asr.seq_region_id
  JOIN coord_system acs ON asr.coord_system_id = acs.coord_system_id
 WHERE ( me.cmp_seq_region_id = 59094 )
   AND ccs.name = acs.name
 GROUP BY asr.name, acs.name, acs.version

