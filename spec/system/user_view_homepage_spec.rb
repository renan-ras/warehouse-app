require "rails_helper"

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app' do
    # Arrange
    
    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Galpões & Estoque')

  end

  it 'e vê os galpões cadastrados' do
    # Arrange
    # Cadastrar 2 galpões: Rio e Maceio
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Descrição do galpão SDU', address: 'Endereço do galpão SDU', zip: '80150-090')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, description: 'Descrição do galpão MCZ', address: 'Endereço do galpão MCZ', zip: '90150-090')

    # Act
    visit('/')

    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    # Garantir que se veja na tela os galpões Rio e Maceio
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange
    
    # Act
    visit('/')

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end