require 'rails_helper'

describe "Usuário clica em editar galpão" do
  it "e visualiza todos os campos já preenchidos" do
    #
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')

    #
    visit root_path
    click_on 'Rio'
    click_on 'Editar'

    #
    expect(page).to have_field('Nome', with: 'Rio')
    expect(page).to have_field('Descrição', with: 'Galpão da zona portuária do Rio')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Endereço', with: 'Avenida do Museu do Amanhã, 1000')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('CEP', with: '20100-000')
    expect(page).to have_field('Área', with: '60000')
  end
  
  it "e edita com sucesso" do
    #
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')

    #
    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    
    fill_in "Nome",	with: "Rio2"
    fill_in "Descrição",	with: "Galpão2"
    fill_in "Código",	with: "RI2"
    fill_in "Endereço",	with: "Avenida2"
    fill_in "Cidade",	with: "RJ2" 
    fill_in "CEP",	with: "22222-000" 
    fill_in "Área",	with: "22000" 
    
    click_on 'Enviar'

    #
    expect(page).to have_content('Galpão atualizado com sucesso')
    expect(page).to have_content('Nome: Rio2')
    expect(page).to have_content('Descrição: Galpão2')
    expect(page).to have_content('Galpão RI2')
    expect(page).to have_content('Endereço: Avenida2')
    expect(page).to have_content('Cidade: RJ2')
    expect(page).to have_content('CEP: 22222-000')
    expect(page).to have_content('Área: 22000')
  end
  
  it "e edita com erro" do
    #
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')

    #
    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    
    fill_in "Nome",	with: "Rio2"
    fill_in "Descrição",	with: "Galpão2"
    fill_in "Código",	with: "RI2"
    fill_in "Endereço",	with: ""
    fill_in "Cidade",	with: "RJ2" 
    fill_in "CEP",	with: "22222-000" 
    fill_in "Área",	with: "22000" 
    
    click_on 'Enviar'

    #
    expect(page).to have_content('Galpão não atualizado')
  end
  
end
