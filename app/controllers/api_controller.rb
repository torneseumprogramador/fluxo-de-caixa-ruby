class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_cors_headers

    def index
        extrato = Caixa.all
        extrato = extrato.where("tipo like ?", "%#{params[:tipo]}%") if params[:tipo].present?

        valor_total = 0
        receita = 0
        despesa = 0

        extrato.each do |item|
            if item.status == Caixa::DEBITO
                despesa += item.valor
            else
                receita += item.valor
            end
        end

        valor_total = receita - despesa

        render json: {
            valor_total: valor_total,
            receita: receita,
            despesa: despesa,
            extrato: extrato
        }
    end

    def excluir
        Caixa.delete(params[:id])
        render json: {}, status: 204
    end

    def cadastrar
        caixa = Caixa.create(tipo: params[:tipo], valor: params[:valor], status: params[:status])
        render json: caixa.to_json, status: 201
    end


    def options
        render json: {}, status: 204
    end

    private

    def set_cors_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, PATCH, DELETE, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
end
