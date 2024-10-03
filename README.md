# VotingContract - Smart Contract de Votación Descentralizada

Este contrato inteligente implementa un sistema de votación en la blockchain que permite añadir propuestas, gestionar una whitelist de votantes autorizados y emitir votos. El administrador puede añadir propuestas y otorgar derechos de voto, mientras que los votantes autorizados pueden emitir sus votos durante el periodo de votación.

## Características

- **Administrador**: Tiene la capacidad de añadir propuestas y autorizar votantes.
- **Whitelist**: Solo las direcciones en la whitelist pueden votar.
- **Propuestas**: Cada propuesta tiene un nombre y un contador de votos.
- **Periodo de votación**: La votación está limitada a un periodo de tiempo (3 días en este contrato).
- **Eventos**: El contrato emite eventos cuando se añade una propuesta, se emite un voto, y cuando termina la votación.

## Despliegue del contrato

Este contrato está escrito en Solidity (versión ^0.8.0). Puedes desplegarlo usando [Remix](https://remix.ethereum.org/) o cualquier otra herramienta compatible con contratos de Ethereum, como Truffle o Hardhat.

### Pasos para desplegar en Remix:

1. Abre [Remix](https://remix.ethereum.org/).
2. Crea un nuevo archivo y copia el código del contrato en el editor.
3. Compila el contrato seleccionando la versión adecuada de Solidity (^0.8.0).
4. Despliega el contrato en una red de pruebas (puedes usar MetaMask para conectarte a redes como Sepolia o Goerli).
5. Interactúa con las funciones del contrato desde Remix o desde cualquier frontend que tengas disponible.

## Funciones del contrato

### `constructor`
- Inicializa el contrato asignando al administrador (el que despliega el contrato) y definiendo un periodo de votación de 3 días.

### `addProposal(string calldata _name)`
- Solo puede ser llamada por el administrador.
- Añade una nueva propuesta con el nombre `_name` y con un contador de votos inicial de 0.
- Emite el evento `ProposalAdded`.

### `addToWhitelist(address _voter)`
- Solo puede ser llamada por el administrador.
- Añade una dirección a la whitelist, lo que otorga al usuario el derecho a votar.

### `vote(uint _proposalIndex)`
- Solo puede ser llamada por un votante autorizado (whitelisted) y dentro del periodo de votación.
- El votante solo puede votar una vez.
- Aumenta el conteo de votos de la propuesta seleccionada.
- Emite el evento `Voted`.

### `endVoting()`
- Solo puede ser llamada por el administrador.
- Termina la votación y marca el contrato como `votingEnded`.
- Emite el evento `VotingEnded`.

### `getProposal(uint _proposalIndex)`
- Devuelve el nombre y el número de votos de la propuesta especificada por el índice `_proposalIndex`.

### `getProposalCount()`
- Devuelve el número total de propuestas.

## Eventos

- **`ProposalAdded(string proposalName)`**: Se emite cuando el administrador añade una nueva propuesta.
- **`Voted(address voter, uint proposalIndex)`**: Se emite cuando un votante autorizado emite su voto.
- **`VotingEnded()`**: Se emite cuando la votación se finaliza manualmente.

## Ejemplo de uso

1. **Desplegar el contrato**:
   - El contrato es desplegado por el administrador, quien define el periodo de votación en el constructor.

2. **Añadir propuestas**:
   - El administrador puede añadir propuestas usando `addProposal("Nombre de la Propuesta")`.

3. **Asignar derecho a votar**:
   - El administrador otorga el derecho a votar añadiendo a los usuarios a la whitelist con `addToWhitelist(voter_address)`.

4. **Emitir voto**:
   - Los usuarios autorizados pueden emitir su voto usando la función `vote(proposalIndex)`, donde `proposalIndex` es el índice de la propuesta en la lista de propuestas.

5. **Finalizar votación**:
   - El administrador puede finalizar manualmente la votación usando `endVoting()`.

## Requisitos

- [MetaMask](https://metamask.io/) para interactuar con la red Ethereum o redes de pruebas.

## Licencia

Este proyecto está licenciado bajo los términos de la licencia **MIT**.
