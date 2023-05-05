require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'com index vazia' do
    #
    #
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    #
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end

  it 'todos cadastrados' do
    # Criar Fornecedores
    Supplier.create!(
      corporate_name: 'Empresa Exemplo Ltda',
      brand_name: 'Exemplo Store',
      registration_number: '12.345.678/0001-99',
      full_address: 'Rua dos Exemplos, 123, Bairro das Amostras',
      city: 'Exemplândia',
      state: 'EX',
      email: 'contato@examplestore.com'
    )

    Supplier.create!(
      corporate_name: 'Soluções Inovadoras Ltda',
      brand_name: 'Inova Store',
      registration_number: '98.765.432/0001-01',
      full_address: 'Avenida das Inovações, 987, Distrito Criativo',
      city: 'Inovação City',
      state: 'IC',
      email: 'contato@inovastore.com'
    )

    # Navegar até a página
    visit suppliers_path

    # Visualizar informações
    expect(page).to have_content 'Exemplo Store'
    expect(page).to have_content 'Exemplândia - EX'

    expect(page).to have_content 'Inova Store'
    expect(page).to have_content 'Inovação City - IC'
  end

  it 'em detalhes' do
    # Criar Fornecedor
    s = Supplier.create!(
      corporate_name: 'Empresa Exemplo Ltda',
      brand_name: 'Exemplo Store',
      registration_number: '12.345.678/0001-99',
      full_address: 'Rua dos Exemplos, 123, Bairro das Amostras',
      city: 'Exemplândia',
      state: 'EX',
      email: 'contato@examplestore.com'
    )

    # Navegar até a página
    visit suppliers_path
    click_on 'Exemplo Store'

    # Visualizar informações
    expect(current_path).to eq supplier_path(s.id)
    expect(page).to have_content 'Fornecedor Exemplo Store'
    expect(page).to have_content 'Empresa Exemplo Ltda'
    expect(page).to have_content 'CNPJ: 12.345.678/0001-99'
    expect(page).to have_content 'Endereço: Rua dos Exemplos, 123, Bairro das Amostras - Exemplândia - EX'
    expect(page).to have_content 'contato@examplestore.com'

  end
end