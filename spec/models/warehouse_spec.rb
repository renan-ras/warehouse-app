require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe "#valid?" do
    context "presence" do
      it "name" do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false 
      end

      it "code" do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false 
      end

      it "city" do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: '', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false 
      end
    end

    context "uniqueness" do
      it "code" do
        # Arrange
        warehouse1 = Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
        # Act
        warehouse2 = Warehouse.new(name: 'Rio2', code: 'SDU', city: 'Rio de Janeiro2', area: 60_002, description: 'Galpão da zona portuária do Rio2', address: 'Avenida do Museu do Amanhã, 1002', zip: '20100-002')
        
        result = warehouse2.valid?

        # Assert
        expect(result).to eq false 
      end

      it "name" do
        # Arrange
        warehouse1 = Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
        # Act
        warehouse2 = Warehouse.new(name: 'Rio', code: 'SD2', city: 'Rio de Janeiro2', area: 60_002, description: 'Galpão da zona portuária do Rio2', address: 'Avenida do Museu do Amanhã, 1002', zip: '20100-002')
        
        result = warehouse2.valid?

        # Assert
        expect(result).to eq false 
      end
    end

    context 'length' do
      it 'code size:2' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'AB', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
          # Act
          result = warehouse.valid?
          
          # Assert
          expect(result).to eq false 
      end

      it 'code size:3' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'ABC', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
          # Act
          result = warehouse.valid?
          
          # Assert
          expect(result).to eq true 
      end

      it 'code size:4' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'ABCD', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
          # Act
          result = warehouse.valid?
          
          # Assert
          expect(result).to eq false 
      end
    end

    context 'format' do
      it 'CEP válido' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-000')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq true
      end

      it 'CEP sem hífen' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100000')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false
      end

      it 'CEP com letra' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '2O100-000')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false
      end

      it 'CEP menor' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '2100-000')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false
      end

      it 'CEP menor2' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-00')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false
      end

      it 'CEP maior' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '920100-000')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false
      end

      it 'CEP maior2' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: 'Galpão da zona portuária do Rio', address: 'Avenida do Museu do Amanhã, 1000', zip: '20100-0009')
        
        # Act
        result = warehouse.valid?
        
        # Assert
        expect(result).to eq false
      end
    end
    
  end
  
end
