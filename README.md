# Ros + Docker

## Description

This repository contains stuff that can help you to work with Ros2 running inside Docker containers.

The main idea is to be able to increase the iteration speed while developing with Ros2.

This is a WIP.

## Requirements

For now, this is working only for Linux and it is only tested in Ubuntu 22.04.

The idea is to make it work in MacOS and Windows in the future.

## Getting started

Clone the repo, jump into the repository folder and run `make help` to see the available recipes.

## Motivation

The main idea is to be able to increase the iteration speed while developing with Ros2.

Working with Ros2 is challenging.

If you run it in your local OS you are almost forced to work with Ubuntu.

Even though I use Ubuntu myself, Ros2 is going to use OS libraries and it is not difficult to mess up things in your system by accident.

Another alternative is to work using a Virtual Machine. This workflow is slow and makes things difficult while working in a team, as things are not really that easy to reproduce on different machines.

Another alternative is Docker.

Working with Docker and Ros2 is challenging, cause you typically want to run GUI applications in your guess system, and that's not the usual workflow you use with Docker.

While other projects are trying to solve this same problem, for example [rocker](https://github.com/osrf/rocker), I decided to implement my own simple approach.
