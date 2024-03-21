# frozen_string_literal: true

class CreateCaixas < ActiveRecord::Migration[7.1]
  def change
    create_table :caixas do |t|
      t.boolean :caixaDisponivel
      t.integer :notasDez
      t.integer :notasVinte
      t.integer :notasCinquenta
      t.integer :notasCem

      t.timestamps
    end
  end
end
