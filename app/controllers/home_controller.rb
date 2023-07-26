class HomeController < ApplicationController
    def index
        @extrato = Caixa.all
        @extrato = @extrato.where("tipo like ?", "%#{params[:tipo]}%") if params[:tipo].present?

        @valor_total = 0
        @receita = 0
        @despesa = 0

        @extrato.each do |item|
            if item.status == Caixa::DEBITO
                @despesa += item.valor
            else
                @receita += item.valor
            end
        end

        @valor_total = @receita - @despesa
    end

    def excluir
        Caixa.delete(params[:id])
        redirect_to "/"
    end

    def adicionar
    end

    def cadastrar
        Caixa.create(tipo: params[:tipo], valor: params[:valor], status: params[:status])
        redirect_to "/"
    end
end
