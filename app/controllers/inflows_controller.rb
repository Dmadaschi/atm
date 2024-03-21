# frozen_string_literal: true

class InflowsController < ApplicationController
  def update
    caixa = Caixa.last || Caixa.new

    if caixa.caixaDisponivel
      caixa.errors.add(:caixaDisponivel, 'caixa-em-uso')
    else
      caixa.update(caixa_params)
    end

    render json: caixa
  end

  private

  def caixa_params
    {
      caixaDisponivel: unsafe_params[:caixaDisponivel],
      notasCem: unsafe_params.dig(:notas, :notasCem),
      notasCinquenta: unsafe_params.dig(:notas, :notasCinquenta),
      notasVinte: unsafe_params.dig(:notas, :notasVinte),
      notasDez: unsafe_params.dig(:notas, :notasDez),
    }
  end

  def unsafe_params
    params.to_unsafe_h.deep_symbolize_keys[:caixa]
  end
end
