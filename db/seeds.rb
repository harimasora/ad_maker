# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Code Tables
CodeTable.create(name: 'Tipo de Unidade de Negócio', kind: 'admin')
CodeTable.create(name: 'Perfil de Usuário', kind: 'admin')
CodeTable.create(name: 'Situação do Usuário', kind: 'admin')
CodeTable.create(name: 'Situação do Processo', kind: 'admin')
CodeTable.create(name: 'Etapa do Processo', kind: 'admin')

# Code Items
table = CodeTable.where(name: 'Tipo de Unidade de Negócio').first
CodeItem.create(short_description: 'TUNFranque', description: 'Franqueadora', code_table: table)
CodeItem.create(short_description: 'TUNMaster', description: 'Master Franquia', code_table: table)
CodeItem.create(short_description: 'TUNFranqui', description: 'Franquia', code_table: table)
table = CodeTable.where(name: 'Perfil de Usuário').first
CodeItem.create(short_description: 'PUAdminist', description: 'Administrador', code_table: table)
CodeItem.create(short_description: 'PUMaster', description: 'Master Franqueado', code_table: table)
CodeItem.create(short_description: 'PUFranquea', description: 'Franqueado', code_table: table)
CodeItem.create(short_description: 'PURepresen', description: 'Representante', code_table: table)
CodeItem.create(short_description: 'PUDesigner', description: 'Designer', code_table: table)
CodeItem.create(short_description: 'PUMarketin', description: 'Marketing', code_table: table)
table = CodeTable.where(name: 'Situação do Usuário').first
CodeItem.create(short_description: 'SUAtivo', description: 'Ativo', code_table: table)
CodeItem.create(short_description: 'SUInativo', description: 'Inativo', code_table: table)
table = CodeTable.where(name: 'Situação do Processo').first
CodeItem.create(short_description: 'SPAtivo', description: 'Ativo', code_table: table)
CodeItem.create(short_description: 'SPInativo', description: 'Inativo', code_table: table)
table = CodeTable.where(name: 'Etapa do Processo').first
CodeItem.create(short_description: 'EPSubmitte', description: 'Submetido', code_table: table)
CodeItem.create(short_description: 'EPDesign', description: 'Design', code_table: table)
CodeItem.create(short_description: 'EPQuality', description: 'Qualidade', code_table: table)
CodeItem.create(short_description: 'EPRejected', description: 'Rejeitado', code_table: table)
CodeItem.create(short_description: 'EPPublishe', description: 'Publicado', code_table: table)
CodeItem.create(short_description: 'EPCancelle', description: 'Cancelado', code_table: table)
