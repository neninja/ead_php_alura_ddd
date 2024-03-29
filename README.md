# ead_php_alura_ddd

> Projeto referente a [este](https://cursos.alura.com.br/course/domain-driven-design-php) curso.

## Setup

```sh
docker-compose up -d
docker-compose exec app composer i
```

Nas próximas inicializações de ambiente não é necessário instalar as dependências do composer, reduzindo o comando para:

```sh
docker-compose up -d
```

>  Caso modifique o `Dockerfile` em algum momento, utilize ``docker-compose up -d --build``

O ambiente pode ser finalizado com:

```sh
docker-compose up down
```


## Execução

```sh
docker-compose exec app composer test
```

```sh
docker-compose exec app php matricular-aluno.php "123.456.789-10" "John Doo" "email@example.com" "54" "999999999"
```

## Resumos sobre o curso

- DTO deve utilizar tipos simples, nada do domínio

### Sobre DDD

- Possui padrões táticos (código) e estratégicos (comunicação)

### Glossário

- Entity: Classes que possuem identidade (e.g. cpf de usuário)
- Value Objects: Classes que **não** possuem identidade (dois telefones com o mesmo numero **são** o mesmo telefone - mesmo com ids diferentes -, dois alunos com o mesmo nome mas cpfs diferentes **não são** o mesmo aluno)
- Repository: Classe que persiste dados
- Service: Classe que realiza tarefa que não fazem parte de nenhuma entidade (pois nas entidades existem regras de negócio relacionadas a seus próprios comportamentos)
    - Domain Service: Regras de dentro das entidades
    - Infrastructure Service: Regras que dependem de detalhes de infra
    - Application Service: Organização do fluxo da aplicação (casos de uso), podem ser entendidos como as Controllers do MVC ou services

- Invariância: Regra de negócio que deve sempre ser verdadeira para os objetos serem válidos
- Aggregate: Relacionamento entre objetos onde um possui os outros, cujo são instanciados/controlados por ele (e.g. telefone é instanciado dentro de um método em aluno)
    - Aggregate root: Controlador dos objetos (o aluno entre aluno e telefone)
    - Sobre persistir aggregates: No exemplo de aluno com telefone, telefone **não** teria um repositório próprio. Suas operações seriam no repositório de seu aggregate root (aluno)
    - Quando vamos relacionar 2 aggregates, não devemos ter a instância deles se relacionando, mas sim apenas as suas identidades. Nesta discussão aqui no fórum esse ponto foi levantado: https://cursos.alura.com.br/forum/topico-referencias-em-agregados-149004
    - https://www.youtube.com/watch?v=1AEOcQWQR2o

### Linguagem ubíqua

Linguagem compartilhada entre equipe especialistas de domínio e especialistas técnicos (devs). O ideal é codar (e.g. nome de classes, props, métodos) utilizando os mesmos termos dos especialistas de domínio.

### Evento de domínio

Situação em que algo notifica algum interessado no domínio (e.g. aluno matriculado)
- Nome: Deve ser de uma ação feita (e.g. `AlunoMatriculado`)
- O objeto de evento deve ter propriedades imutáveis e entregar somente as identidades das entidades, pois dependendo de quem ouvir esse evento não faz sentido realizar as ações da entidade (e.g. financeiro adicionar telefone no aluno)

- Precisa de uma classe que publique o evento e notifique os ouvintes (classes que reagem ao evento)

- Comumente as applications services receberão o publicador de evento como parâmetro por injeção de dependência

### Bounded Contexts

São separados para permitir independência de crescimento, baixo acoplamento e maior facilidade de manutenção. Quando contextos diferentes exigem uma mesma dependência ela fica pode:

1. ser duplicada - mais prático porém afeta a manutenção futura da base
2. criar um contexto compartilhado (Shared Kernel) para servir ambos - mais flexibilidade, porém aumenta a complexidade

## Links úteis

- https://github.com/dddinphp/last-wishes
- https://martinfowler.com/bliki/BoundedContext.html
- http://www.fabriciorissetto.com/blog/ddd-bounded-context/
- https://leanpub.com/ddd-in-php
