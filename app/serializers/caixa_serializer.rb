class CaixaSerializer < ActiveModel::Serializer
  attributes :caixa, :erros

  def caixa
    {
      caixaDisponivel: @object.caixaDisponivel,
      notas: {
        notasCem: @object.notasCem,
        notasCinquenta: @object.notasCinquenta,
        notasVinte: @object.notasVinte,
        notasDez: @object.notasDez
      }
    }
  end

  def erros
    @object.errors.messages.values.flatten
  end

end
