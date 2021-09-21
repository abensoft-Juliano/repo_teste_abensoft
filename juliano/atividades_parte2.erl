-module(atividades_parte2).
-export([all_but_last1/0,
        encode_list/0,
        prime_factor/1,
        is_prime/0,
        factor1/1,
        decode1/0]).



all_but_last1() ->
    all_but_last([1,2,3,4]).

all_but_last(Lista) ->
    all_but_last(Lista, []).

all_but_last([], Acc) ->
    lists:reverse(Acc);

all_but_last([_ListaCabeca|[]], Acc) ->
    all_but_last([], Acc);

all_but_last([ListaCabeca|ListaResto], Acc) ->
    all_but_last(ListaResto, [ListaCabeca|Acc]).



decode1() ->
    decode([{2, a},{3, c}, {1,b},d]).

decode(Lista) ->
    decode(Lista, []).

decode([], Acc) ->
    lists:reverse(Acc);
decode([{Numero1, Elem2} | ListaResto], Acc) ->
    Acc1 = contador(Numero1, Elem2, Acc),
    io:format("Acc = ~p, Acc1 = ~p~n", [Acc, Acc1]),
    decode(ListaResto, Acc1);
decode([Elem|ElemResto], Acc) ->
    decode(ElemResto, [Elem|Acc]).



contador(Quantidade, Letra, Acc) ->
    Contados = contador(Quantidade, Letra, [], 0),
    io:format("Contados = ~p, Acc = ~p~n", [Contados, Acc]),
    merge(Contados, Acc).

contador(Quantidade, Letra, Acc, Quantidade) ->
    Acc;
contador(Quantidade, Letra, Acc, QtAtual) ->
    contador(Quantidade, Letra, [Letra|Acc], QtAtual+1).



merge(Listas1, Listas2) ->
    merge(Listas1, Listas2, []).

merge([], [], Acc) ->
    lists:reverse(Acc);

merge([], [L2Cabeca|L2Resto], Acc) ->
    merge([], L2Resto, [L2Cabeca|Acc]);

merge([L1Cabeca|L1Resto], Lista2,  Acc) ->
    merge(L1Resto, Lista2, [L1Cabeca|Acc]).


encode_list() ->
    encode_list([a]).

encode_list([]) ->
    [];
encode_list([Element|Resto]) ->
    encode(Element, Resto, 0, []).

encode(ElemAtual, [], 0, Acc) ->
    lists:reverse([ElemAtual|Acc]);
encode(ElemAtual, [], Contador, Acc) ->
   lists:reverse([{ElemAtual, Contador+1}|Acc]);
encode(ElemAtual, [ElemAtual|Resto], Contador,  Acc)  ->
    encode(ElemAtual, Resto, Contador+1, Acc);
encode(ElemAtual, [Elem|Resto], 0, Acc) ->
    encode(Elem, Resto, 0, [ElemAtual|Acc]);
encode(ElemAtual, [Elem|Resto], Contador, Acc) ->
    encode(Elem, Resto, 0, [{ElemAtual, Contador+1}|Acc]).



is_prime() ->
     prime(2).

prime(Numero) ->
    prime(Numero, 3).

prime(Numero, Contador) ->
    TestaValor = case Numero == 2 of
        true -> true;
        _ -> prime1(Numero, Contador)
    end.

prime1(Numero, Contador) ->
    TestaValor = Numero rem 2,
    case TestaValor == 0 of
        true -> false;
        _ -> calcula(Numero, Contador)
    end.
calcula(Numero, Numero) ->
    true;

calcula(Numero, Contador) ->
    TestaValor = Numero rem Contador,
    case TestaValor == 0 of
        true -> false;
        _ -> calcula(Numero, Contador+2)
    end.


primos() ->
    [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547].

prime_factor(Valor) ->
    prime_factor(Valor, []).

prime_factor(Valor, Acc) ->
    Primo = is_divisible_by(Valor, primos()),
        case Primo of
            not_found -> error;
            _ ->
                case Valor div Primo of
                    1 -> [Primo | Acc];
                    ProxValor -> prime_factor(ProxValor, [Primo | Acc])
                end
        end.

is_divisible_by(_Valor, []) ->
    not_found;
is_divisible_by(Valor, [Primo | _Primos]) when Valor rem Primo == 0 ->
    Primo;
is_divisible_by(Valor, [_|Primos]) ->
    is_divisible_by(Valor, Primos).


factor1(Numero) ->
    factor1(Numero, primos(), []).

factor1(Numero, _, Acc) when Numero == 1 ->
    Acc;
factor1(Numero, [Divisor|Primos],  Acc) when Numero rem Divisor == 0 ->
    NewNumero = Numero div Divisor,
    factor1(NewNumero, primos(), [Divisor|Acc]);
factor1(Numero, [_|Primos], Acc) ->
    factor1(Numero, Primos, Acc).








