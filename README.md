# Distributed Artificial Intelligence and Intelligent Agents (ID2209) Final Project

# Multi agent system for resource delegation between agents and stations in a dynamic 2D environment

# Abstract
This project focuses on simulating resource delivery between agents in a dynamic 2D
environment. Agents communicate with each other via FIPA protocol to meet at agreed
coordinates that reduces total distance travelled for every agent in selected group. The method
used for finding the coordinate is inverse factor point based on the agent’s speed.

# Introduction
In an area where demand for resources needs to be answered quickly on random occasions
can be defined as high critical/high risk area. An idea of such an area can be refugee camps for
people who have had to evacuate their city due to natural disasters. These camps might be
scattered around so when a request for resources, like water or food would be made, someone
from the camps would need to travel to the nearest supply station or a delivery truck would need
to transport them over to each camp. The truck could map out the camps that needed resources
before taking off and travel the shortest distance (traveling salesman problem) but that means it
would have to choose which camps to go to first. Since supplies are vital the risk of letting some
camps wait longer might lead to starvation of those resources which is an unwanted situation.
We could shorten the time of delivery if the requesters from the requesting camps would meet
the truck midway instead of the delivery truck travelling to each location individually. But how
would we decide on the best meet up coordinate when the requesters are different individuals?
And what happens if a request is made after the delivery truck has left the supply center?
Our simulation solution addresses this problem by creating a multi-agent system for such
resource delegation in a dynamic environment. In the simulation there are camps where
resources are consumed on a different rate and also supply stations where stocks of resources
are kept. When a camp is running out of resources, a requester from a camp contacts a supply
station for resources. The project will mainly focus on cooperation and collaboration between
agents to minimize the total delivery time of resources.

This project is a final project in the course Distributed Artificial Intelligence and Intelligent Agents
(ID2209) at KTH. The main goal of this project is to try out methods studied in the course to
incorporate them in a multi agent system in order to deliver a basic model that simulates these
behaviours.

# Platform used - GAMA 1.6:

GAMA is a Java based modeling language to develop simulation for agent environment. It’s
user friendly and high level language allows complex behaviours and interactions in a few lines
of code. More information about the platform can be found here .

Note: To run the file, please follow the instructions in the readme.txt file. The presentation
accompanied this report can also be found under the name slides.pdf.
