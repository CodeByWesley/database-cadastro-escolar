-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: mariadb-208392-db.mariadb-208392:16400
-- Tempo de geração: 22-Fev-2026 às 23:45
-- Versão do servidor: 11.1.2-MariaDB-1:11.1.2+maria~ubu2004
-- versão do PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `CadastroEscolar`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `alunos`
--

CREATE TABLE `alunos` (
                          `id_aluno` int(11) NOT NULL,
                          `nome_aluno` varchar(100) DEFAULT NULL,
                          `nome_pai` varchar(255) DEFAULT NULL COMMENT 'nome do pai',
                          `nome_mae` varchar(255) DEFAULT NULL COMMENT 'nome da mae',
                          `email` varchar(100) NOT NULL COMMENT 'email do aluno',
                          `cpf` varchar(11) NOT NULL COMMENT 'cpf do aluno',
                          `senha` varchar(15) NOT NULL COMMENT 'senha do aluno',
                          `data_nascimento` date NOT NULL COMMENT 'data de nascimento do aluno',
                          `rua` varchar(150) DEFAULT NULL COMMENT 'rua do endereco',
                          `numero_da_casa` varchar(20) DEFAULT NULL,
                          `bairro` varchar(100) DEFAULT NULL COMMENT 'bairro',
                          `cidade` varchar(100) DEFAULT NULL COMMENT 'cidade',
                          `estado` varchar(2) DEFAULT NULL COMMENT 'estado (UF)',
                          `cep` varchar(8) DEFAULT NULL COMMENT 'CEP',
                          `telefone_aluno` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `avaliacoes`
--

CREATE TABLE `avaliacoes` (
                              `id_avaliacao` int(11) NOT NULL,
                              `turma_id` int(11) NOT NULL,
                              `curso_id` int(11) NOT NULL,
                              `titulo` varchar(100) NOT NULL,
                              `tipo` enum('PROVA','TRABALHO','ATIVIDADE','SEMINARIO') NOT NULL,
                              `data_avaliacao` date NOT NULL,
                              `peso` decimal(4,2) DEFAULT 1.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cursos`
--

CREATE TABLE `cursos` (
                          `id_curso` int(11) NOT NULL,
                          `nome_curso` varchar(100) DEFAULT NULL,
                          `carga_horaria` int(11) DEFAULT NULL,
                          `nivel` varchar(50) DEFAULT NULL,
                          `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
                                `id_funcionario` int(11) NOT NULL,
                                `nome_funcionario` varchar(100) NOT NULL,
                                `cpf_funcionario` varchar(14) NOT NULL,
                                `telefone_funcionario` varchar(20) DEFAULT NULL,
                                `email_funcionario` varchar(100) DEFAULT NULL,
                                `cargo` enum('DIRETOR','COORDENADOR','PROFESSOR','SECRETARIO','AUXILIAR_ADMINISTRATIVO','PORTEIRO','ZELADOR','FAXINEIRO','INSPETOR') NOT NULL,
                                `salario` decimal(10,2) DEFAULT NULL,
                                `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `matriculas`
--

CREATE TABLE `matriculas` (
                              `id_matricula` int(11) NOT NULL,
                              `id_aluno` int(11) NOT NULL,
                              `id_turma` int(11) NOT NULL,
                              `data_matricula` date DEFAULT NULL,
                              `status` enum('Matriculada','Trancada','Cancelada','Concluida') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `notas`
--

CREATE TABLE `notas` (
                         `id_nota` int(11) NOT NULL,
                         `avaliacao_id` int(11) NOT NULL,
                         `matricula_id` int(11) NOT NULL,
                         `nota` decimal(5,2) NOT NULL,
                         `observacao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `salas`
--

CREATE TABLE `salas` (
                         `id_sala` int(11) NOT NULL,
                         `nome` varchar(50) DEFAULT NULL,
                         `capacidade` int(11) DEFAULT NULL,
                         `tipo` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `turmas`
--

CREATE TABLE `turmas` (
                          `id_turma` int(11) NOT NULL,
                          `id_curso` int(11) NOT NULL,
                          `turno` varchar(20) DEFAULT NULL,
                          `ano` int(11) DEFAULT NULL,
                          `semestre` int(11) DEFAULT NULL,
                          `vagas` int(11) DEFAULT NULL,
                          `id_sala` int(11) NOT NULL,
                          `professor_titular_id` int(11) NOT NULL,
                          `professor_substituto_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
                            `id_usuario` int(11) NOT NULL,
                            `email` varchar(100) NOT NULL,
                            `senha_hash` varchar(255) NOT NULL,
                            `perfil` enum('ADMIN','SECRETARIA','COORDENACAO','PROFESSOR','ALUNO') NOT NULL,
                            `aluno_id` int(11) DEFAULT NULL,
                            `funcionario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `alunos`
--
ALTER TABLE `alunos`
    ADD PRIMARY KEY (`id_aluno`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Índices para tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
    ADD PRIMARY KEY (`id_avaliacao`),
  ADD KEY `turma_id` (`turma_id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Índices para tabela `cursos`
--
ALTER TABLE `cursos`
    ADD PRIMARY KEY (`id_curso`);

--
-- Índices para tabela `funcionarios`
--
ALTER TABLE `funcionarios`
    ADD PRIMARY KEY (`id_funcionario`),
  ADD UNIQUE KEY `cpf_funcionario` (`cpf_funcionario`),
  ADD UNIQUE KEY `email_funcionario` (`email_funcionario`);

--
-- Índices para tabela `matriculas`
--
ALTER TABLE `matriculas`
    ADD PRIMARY KEY (`id_matricula`),
  ADD UNIQUE KEY `unique_aluno_turma` (`id_aluno`,`id_turma`),
  ADD KEY `idx_matricula_aluno` (`id_aluno`) USING BTREE,
  ADD KEY `idx_matricula_turma` (`id_turma`) USING BTREE;

--
-- Índices para tabela `notas`
--
ALTER TABLE `notas`
    ADD PRIMARY KEY (`id_nota`),
  ADD UNIQUE KEY `uk_avaliacao_matricula` (`avaliacao_id`,`matricula_id`),
  ADD KEY `matricula_id` (`matricula_id`);

--
-- Índices para tabela `salas`
--
ALTER TABLE `salas`
    ADD PRIMARY KEY (`id_sala`);

--
-- Índices para tabela `turmas`
--
ALTER TABLE `turmas`
    ADD PRIMARY KEY (`id_turma`),
  ADD KEY `idx_turmas_id_curso` (`id_curso`),
  ADD KEY `idx_turmas_id_sala` (`id_sala`),
  ADD KEY `fk_turmas_prof_titular` (`professor_titular_id`),
  ADD KEY `fk_turmas_prof_substituto` (`professor_substituto_id`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
    ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `aluno_id` (`aluno_id`),
  ADD KEY `funcionario_id` (`funcionario_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alunos`
--
ALTER TABLE `alunos`
    MODIFY `id_aluno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
    MODIFY `id_avaliacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `cursos`
--
ALTER TABLE `cursos`
    MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
    MODIFY `id_funcionario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `matriculas`
--
ALTER TABLE `matriculas`
    MODIFY `id_matricula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `notas`
--
ALTER TABLE `notas`
    MODIFY `id_nota` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `salas`
--
ALTER TABLE `salas`
    MODIFY `id_sala` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `turmas`
--
ALTER TABLE `turmas`
    MODIFY `id_turma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
    MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `avaliacoes`
--
ALTER TABLE `avaliacoes`
    ADD CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id_turma`),
  ADD CONSTRAINT `avaliacoes_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id_curso`);

--
-- Limitadores para a tabela `matriculas`
--
ALTER TABLE `matriculas`
    ADD CONSTRAINT `fk_matricula_aluno` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id_aluno`),
  ADD CONSTRAINT `fk_matriculas_id_turma` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`);

--
-- Limitadores para a tabela `notas`
--
ALTER TABLE `notas`
    ADD CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`avaliacao_id`) REFERENCES `avaliacoes` (`id_avaliacao`),
  ADD CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id_matricula`);

--
-- Limitadores para a tabela `turmas`
--
ALTER TABLE `turmas`
    ADD CONSTRAINT `fk_turmas_id_curso` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`),
  ADD CONSTRAINT `fk_turmas_id_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`),
  ADD CONSTRAINT `fk_turmas_prof_substituto` FOREIGN KEY (`professor_substituto_id`) REFERENCES `funcionarios` (`id_funcionario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_turmas_prof_titular` FOREIGN KEY (`professor_titular_id`) REFERENCES `funcionarios` (`id_funcionario`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `usuarios`
--
ALTER TABLE `usuarios`
    ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id_aluno`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionarios` (`id_funcionario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
