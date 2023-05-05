require 'rails_helper'

describe "Usuário visualiza página de cadastro de galpões" do
  context 'Uso normal' do
    it "com todos os campos do formulário" do
      # Arrange
      # Não necessário
      
      # Act
      visit root_path
      click_on 'Cadastrar Galpão'
      
      # Assert
      expect(page).to have_field('Nome')
      expect(page).to have_field('Descrição')
      expect(page).to have_field('Código')
      expect(page).to have_field('Endereço')
      expect(page).to have_field('Cidade')
      expect(page).to have_field('CEP')
      expect(page).to have_field('Área')

    end

    it "e salva dados com sucesso" do
      # Arrange
      # Não necessário

      # Act
      visit root_path
      click_on 'Cadastrar Galpão'

      fill_in "Nome",	with: "Rio de Janeiro"
      fill_in "Descrição",	with: "Galpão da zona portuária do Rio"
      fill_in "Código",	with: "RIO"
      fill_in "Endereço",	with: "Avenida do Museu do Amanhã, 1000"
      fill_in "Cidade",	with: "Rio de Janeiro" 
      fill_in "CEP",	with: "20100-000" 
      fill_in "Área",	with: "32000" 
      click_on 'Enviar'
      
      # Assert
      expect(current_path).to eq root_path
      expect(page).to have_content('Rio de Janeiro')
      expect(page).to have_content('RIO')
      expect(page).to have_content('32000 m2')
      
      expect(page).to have_content('Galpão cadastrado com sucesso.')

    end

  end

  context 'Erros/Validações' do
    it "não aceita campos em branco" do
      # Arrange
      # Não necessário

      # Act
      visit root_path
      click_on 'Cadastrar Galpão'

      fill_in "Nome",	with: ""
      fill_in "Descrição",	with: ""
      fill_in "Código",	with: ""
      fill_in "Endereço",	with: ""
      fill_in "Cidade",	with: "" 
      fill_in "CEP",	with: "" 
      fill_in "Área",	with: "" 

      click_on 'Enviar'
      
      # Assert
      expect(page).to have_content('Galpão não cadastrado.')
      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('Código não pode ficar em branco')
      expect(page).to have_content('Cidade não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
      expect(page).to have_content('Endereço não pode ficar em branco')
      expect(page).to have_content('CEP não pode ficar em branco')
      expect(page).to have_content('Área não pode ficar em branco')
      expect(page).to have_content('Código não possui o tamanho esperado (3 caracteres)')
      expect(page).to have_content 'CEP deve ter o formato 00000-000'

    end

    it 'garante que o nome do galpão seja único' do
      # Arrange
      # Cadastrar um galpão
      Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
      
      # Act
      # Cadastrar outro galpão com nome repetido
      visit new_warehouse_path
      fill_in "Nome",	with: "Rio"
      fill_in "Código",	with: "SD2"
      fill_in "Cidade",	with: "Rio de Janeiro" 
      fill_in "Área",	with: "60000"
      fill_in "Descrição",	with: "Galpão da zona portuária do Rio"
      fill_in "Endereço",	with: "Avenida do Museu do Amanhã, 1000"
      fill_in "CEP",	with: "20100-000" 
      click_on 'Enviar'
      
      # Assert
      # Verificar erro na criação do galpão
      expect(page).to have_content('Galpão não cadastrado.')
    end

    it 'garante que o código do galpão seja único' do
      # Arrange
      # Cadastrar um galpão
      Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
      
        # Act
        # Cadastrar outro galpão com código repetido
        visit new_warehouse_path
        fill_in "Nome",	with: "Rio2"
        fill_in "Código",	with: "SDU"
        fill_in "Cidade",	with: "Rio de Janeiro" 
        fill_in "Área",	with: "60000"
        fill_in "Descrição",	with: "Galpão da zona portuária do Rio"
        fill_in "Endereço",	with: "Avenida do Museu do Amanhã, 1000"
        fill_in "CEP",	with: "20100-000" 
        click_on 'Enviar'
        
        # Assert
        # Verificar erro na criação do galpão
        expect(page).to have_content('Galpão não cadastrado.')
    end

    it 'garante que o CEP seja válido no formato: 00000-000. Parte 1: Sem hífen' do
      # Arrange
      # Não necessário

      # Act
      visit new_warehouse_path

      fill_in "Nome",	with: "Rio de Janeiro"
      fill_in "Descrição",	with: "Galpão da zona portuária do Rio"
      fill_in "Código",	with: "RIO"
      fill_in "Endereço",	with: "Avenida do Museu do Amanhã, 1000"
      fill_in "Cidade",	with: "Rio de Janeiro" 
      fill_in "Área",	with: "32000"

      fill_in "CEP",	with: "20100000" #CEP sem hífen
      click_on 'Enviar'
      
      # Assert      
      expect(page).to have_content('Galpão não cadastrado.')
    end

    it 'garante que o CEP seja válido no formato: 00000-000. Parte 2: Com letra' do
      # Arrange
      # Não necessário

      # Act
      visit new_warehouse_path

      fill_in "Nome",	with: "Rio de Janeiro"
      fill_in "Descrição",	with: "Galpão da zona portuária do Rio"
      fill_in "Código",	with: "RIO"
      fill_in "Endereço",	with: "Avenida do Museu do Amanhã, 1000"
      fill_in "Cidade",	with: "Rio de Janeiro" 
      fill_in "Área",	with: "32000"

      fill_in "CEP",	with: "2O100-000" #CEP com letra (O != 0)
      click_on 'Enviar'
      
      # Assert      
      expect(page).to have_content('Galpão não cadastrado.')
    end

    it 'garante que o CEP seja válido no formato: 00000-000. Parte 3: Menor' do
      # Arrange
      # Não necessário

      # Act
      visit new_warehouse_path

      fill_in "Nome",	with: "Rio de Janeiro"
      fill_in "Descrição",	with: "Galpão da zona portuária do Rio"
      fill_in "Código",	with: "RIO"
      fill_in "Endereço",	with: "Avenida do Museu do Amanhã, 1000"
      fill_in "Cidade",	with: "Rio de Janeiro" 
      fill_in "Área",	with: "32000"

      fill_in "CEP",	with: "20100-00" #CEP menor
      click_on 'Enviar'
      
      # Assert
      expect(page).to have_content('Galpão não cadastrado.')
    end

  end
  
end
