# Digital Design Verification Projects
This repository contains implementations with different verification projects, demonstrating comprehensive UVM-based verification approaches.

## Projects Overview

### 1. Up Counter with UVM Testbench
- Basic up counter implementation
- Complete UVM-based verification environment featuring:
  - Reusable components (Sequencer, Driver, Monitor)
  - Scoreboard for result checking
  - Coverage collection
  - Test scenarios
- Performance and coverage reports
- Includes waveform visualization

### 2. Module-12 Up/Down Loadable Counter with UVM
- Advanced implementation of a 12-bit up/down counter
- Comprehensive UVM verification environment including:
  - Layered testbench architecture
  - Configuration database usage
  - Advanced coverage metrics
  - Comprehensive test scenarios
- Full verification reports and analysis
- Architecture diagram and waveform visualization

### 3. Pattern Detection FSM (1011) with UVM
- Finite State Machine implementation for detecting pattern "1011"
- Complete UVM verification environment featuring:
  - Agent-based architecture
  - Advanced test scenarios
  - Pattern detection verification
  - Coverage metrics
- Detailed architecture diagram
- Comprehensive test reports

### 4. FIFO Memory with UVM
- Synchronous FIFO implementation with configurable depth (16 entries)
- Advanced UVM verification environment including:
  - Dual-agent architecture (Read and Write)
  - Protocol checking and assertions
  - Advanced coverage metrics
- Features verified:
  - Read/Write operations
  - Full/Empty conditions
  - Reset behavior
  - Pointer wraparound
  - Back-to-back operations
- Detailed waveform analysis
- Coverage and assertion reports

## Directory Structure
```
├── FIFO_UVM
│   ├── arch.jpeg
│   ├── env
│   ├── rd_agt
│   ├── README.md
│   ├── report
│   ├── rtl
│   ├── sim
│   ├── test
│   ├── top
│   ├── waveform.png
│   └── wr_agt
├── mod12_counter_uvm
│   ├── architecture.jpeg
│   ├── env
│   ├── rd_agt
│   ├── README.md
│   ├── report
│   ├── rtl
│   ├── sim
│   ├── test
│   ├── top
│   ├── Waveform.png
│   └── wr_agt
├── pattern_1011
│   ├── agt
│   ├── arch.jpeg
│   ├── env
│   ├── README.md
│   ├── report
│   ├── rtl
│   ├── sim
│   ├── state.jpeg
│   ├── test
│   ├── top
│   └── waveform.png
├── README.md
└── up_counter_uvm
    ├── agt
    ├── arch.jpeg
    ├── env
    ├── README.md
    ├── report
    ├── rtl
    ├── sim
    ├── test
    ├── top
    └── Waveform.png
```

## Key Features
- UVM-based verification methodologies
- Comprehensive test coverage
- Detailed architectural diagrams
- Waveform visualizations
- Extensive reporting

## Requirements
- QuestaSim/ModelSim for simulation
- UVM 1.2 or later
- SystemVerilog supported simulator
- VCS/Questa verification platforms

## Getting Started
1. Clone the repository
2. Navigate to the desired project directory
3. Follow the specific README in each project folder for detailed instructions
4. Run simulation using provided Makefile in the sim directory

## Reports
Each project contains detailed reports including:
- Functional coverage metrics
- Test scenarios and their results
- Architecture diagrams
- Waveform analysis
- Follow each README.md file for specific instructions

## Contributing
Feel free to contribute by:
- Reporting bugs
- Suggesting enhancements
- Adding new test scenarios
- Improving documentation
