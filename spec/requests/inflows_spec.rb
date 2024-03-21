require 'rails_helper'

describe 'outflow' do
  context 'generate caixa' do
    it 'successfully' do
      headers = { accept: 'application/json' }
      params = {
        caixa:{
          caixaDisponivel: false,
          notas:{
            notasDez: 100,
            notasVinte: 50,
            notasCinquenta: 10,
            notasCem: 30
          }
        }
      }

      patch inflows_path, params: params, headers: headers
      caixa = Caixa.last

      expect(response).to have_http_status(:ok)
      expect(caixa.caixaDisponivel).to be_falsey
      expect(caixa.notasCem).to eq(30)
      expect(caixa.notasCinquenta).to eq(10)
      expect(caixa.notasVinte).to eq(50)
      expect(caixa.notasDez).to eq(100)
    end

    it 'and returs json' do
      headers = { accept: 'application/json' }
      params = {
        caixa:{
          caixaDisponivel: false,
          notas:{
            notasDez: 100,
            notasVinte: 50,
            notasCinquenta: 10,
            notasCem: 30
          }
        }
      }

      patch inflows_path, params: params, headers: headers
      caixa = JSON.parse(response.body, symbolize_names: true)[:caixa]
      errors = JSON.parse(response.body, symbolize_names: true)[:erros]

      expect(caixa[:caixaDisponivel]).to be_falsey
      expect(caixa[:notas][:notasDez]).to eq(100)
      expect(caixa[:notas][:notasVinte]).to eq(50)
      expect(caixa[:notas][:notasCinquenta]).to eq(10)
      expect(caixa[:notas][:notasCem]).to eq(30)
      expect(errors).to be_empty
    end

    context 'with multiple entries' do
      it 'update caixa if caixaDisponivel is false' do
        headers = { accept: 'application/json' }

        Caixa.create(caixaDisponivel: false, notasCem: 30, notasVinte: 50,
                     notasCinquenta: 10, notasDez: 100)

        params = {
          caixa:{
            caixaDisponivel: true,
            notas:{
              notasDez: 5,
              notasVinte: 5,
              notasCinquenta: 5,
              notasCem: 15
            }
          }
        }

        patch inflows_path, params: params, headers: headers
        caixa = JSON.parse(response.body, symbolize_names: true)[:caixa]
        errors = JSON.parse(response.body, symbolize_names: true)[:erros]

        expect(caixa[:caixaDisponivel]).to be_truthy
        expect(caixa[:notas][:notasDez]).to eq(5)
        expect(caixa[:notas][:notasVinte]).to eq(5)
        expect(caixa[:notas][:notasCinquenta]).to eq(5)
        expect(caixa[:notas][:notasCem]).to eq(15)
        expect(errors).to be_empty
      end

      it 'returns error if caixa is aleready set as caixaDisponivel' do
        headers = { accept: 'application/json' }

        Caixa.create(caixaDisponivel: true, notasCem: 30, notasVinte: 50,
                     notasCinquenta: 10, notasDez: 100)

        params = {
          caixa:{
            caixaDisponivel: true,
            notas:{
              notasDez: 5,
              notasVinte: 5,
              notasCinquenta: 5,
              notasCem: 15
            }
          }
        }

        patch inflows_path, params: params, headers: headers
        caixa = JSON.parse(response.body, symbolize_names: true)[:caixa]
        errors = JSON.parse(response.body, symbolize_names: true)[:erros]

        expect(caixa[:caixaDisponivel]).to be_truthy
        expect(caixa[:notas][:notasDez]).to eq(100)
        expect(caixa[:notas][:notasVinte]).to eq(50)
        expect(caixa[:notas][:notasCinquenta]).to eq(10)
        expect(caixa[:notas][:notasCem]).to eq(30)
        expect(errors).to include('caixa-em-uso')
      end
    end
  end
end
