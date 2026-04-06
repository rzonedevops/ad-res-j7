"""
CogSim Core Base Module
Multi-paradigm simulation framework for legal case analysis.
Based on AnyLogic modeling paradigms: ABM, DES, and System Dynamics.
"""

from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from enum import Enum, auto
from typing import List, Dict, Optional, Set, Callable, Any, Tuple
import heapq
import random
import json


# =============================================================================
# Core Enumerations
# =============================================================================

class SimulationState(Enum):
    """Simulation execution states."""
    INITIALIZED = auto()
    RUNNING = auto()
    PAUSED = auto()
    COMPLETED = auto()
    ERROR = auto()


class EventType(Enum):
    """Types of simulation events."""
    SCHEDULED = auto()
    CONDITIONAL = auto()
    IMMEDIATE = auto()
    PERIODIC = auto()


class LogLevel(Enum):
    """Logging levels for simulation output."""
    DEBUG = 0
    INFO = 1
    WARNING = 2
    ERROR = 3
    CRITICAL = 4


# =============================================================================
# Core Event System
# =============================================================================

@dataclass(order=True)
class Event:
    """
    Base event class for discrete-event simulation.
    Events are ordered by time, then by priority.
    """
    time: float
    priority: int = field(compare=True, default=0)
    event_id: str = field(compare=False, default="")
    event_type: EventType = field(compare=False, default=EventType.SCHEDULED)
    callback: Callable = field(compare=False, default=None)
    data: Dict = field(compare=False, default_factory=dict)
    description: str = field(compare=False, default="")
    
    def execute(self, engine: 'BaseEngine') -> Optional['Event']:
        """Execute the event callback and return any follow-up event."""
        if self.callback:
            return self.callback(engine, self)
        return None


class EventQueue:
    """Priority queue for managing simulation events."""
    
    def __init__(self):
        self._queue: List[Event] = []
        self._event_counter = 0
    
    def schedule(self, event: Event) -> None:
        """Add an event to the queue."""
        heapq.heappush(self._queue, event)
        self._event_counter += 1
    
    def pop(self) -> Optional[Event]:
        """Remove and return the next event."""
        if self._queue:
            return heapq.heappop(self._queue)
        return None
    
    def peek(self) -> Optional[Event]:
        """Return the next event without removing it."""
        if self._queue:
            return self._queue[0]
        return None
    
    def is_empty(self) -> bool:
        """Check if the queue is empty."""
        return len(self._queue) == 0
    
    def clear(self) -> None:
        """Clear all events from the queue."""
        self._queue.clear()
    
    def __len__(self) -> int:
        return len(self._queue)


# =============================================================================
# Data Collection
# =============================================================================

@dataclass
class DataPoint:
    """Single data point for time-series collection."""
    time: float
    value: Any
    label: str = ""
    metadata: Dict = field(default_factory=dict)


class DataCollector:
    """Collects and stores simulation data for analysis."""
    
    def __init__(self, name: str):
        self.name = name
        self.data: List[DataPoint] = []
        self.aggregates: Dict[str, List[float]] = {}
    
    def record(self, time: float, value: Any, label: str = "", metadata: Dict = None) -> None:
        """Record a data point."""
        self.data.append(DataPoint(
            time=time,
            value=value,
            label=label,
            metadata=metadata or {}
        ))
    
    def get_time_series(self, label: str = None) -> List[Tuple[float, Any]]:
        """Get time series data, optionally filtered by label."""
        if label:
            return [(d.time, d.value) for d in self.data if d.label == label]
        return [(d.time, d.value) for d in self.data]
    
    def get_statistics(self) -> Dict[str, float]:
        """Calculate basic statistics on numeric data."""
        numeric_values = [d.value for d in self.data if isinstance(d.value, (int, float))]
        if not numeric_values:
            return {}
        
        return {
            "count": len(numeric_values),
            "sum": sum(numeric_values),
            "mean": sum(numeric_values) / len(numeric_values),
            "min": min(numeric_values),
            "max": max(numeric_values)
        }
    
    def to_dict(self) -> Dict:
        """Convert to dictionary for serialization."""
        return {
            "name": self.name,
            "data_points": len(self.data),
            "statistics": self.get_statistics(),
            "data": [
                {"time": d.time, "value": d.value, "label": d.label}
                for d in self.data
            ]
        }


# =============================================================================
# Base Engine
# =============================================================================

class BaseEngine(ABC):
    """
    Abstract base class for all simulation engines.
    Provides common functionality for time management, event handling, and data collection.
    """
    
    def __init__(self, name: str = "Simulation", seed: int = None):
        self.name = name
        self.current_time: float = 0.0
        self.end_time: float = 0.0
        self.state: SimulationState = SimulationState.INITIALIZED
        self.event_queue: EventQueue = EventQueue()
        self.data_collectors: Dict[str, DataCollector] = {}
        self.log_level: LogLevel = LogLevel.INFO
        self.logs: List[Dict] = []
        
        # Random number generator with optional seed
        self.rng = random.Random(seed)
        self._seed = seed
        
        # Callbacks for simulation events
        self.on_step: List[Callable] = []
        self.on_complete: List[Callable] = []
        self.on_error: List[Callable] = []
    
    def log(self, message: str, level: LogLevel = LogLevel.INFO, data: Dict = None) -> None:
        """Log a message with timestamp."""
        if level.value >= self.log_level.value:
            log_entry = {
                "time": self.current_time,
                "level": level.name,
                "message": message,
                "data": data or {}
            }
            self.logs.append(log_entry)
    
    def create_collector(self, name: str) -> DataCollector:
        """Create and register a data collector."""
        collector = DataCollector(name)
        self.data_collectors[name] = collector
        return collector
    
    def schedule_event(self, event: Event) -> None:
        """Schedule an event for future execution."""
        self.event_queue.schedule(event)
    
    def schedule_at(self, time: float, callback: Callable, 
                    description: str = "", data: Dict = None) -> Event:
        """Convenience method to schedule a callback at a specific time."""
        event = Event(
            time=time,
            callback=callback,
            description=description,
            data=data or {}
        )
        self.schedule_event(event)
        return event
    
    def schedule_in(self, delay: float, callback: Callable,
                    description: str = "", data: Dict = None) -> Event:
        """Convenience method to schedule a callback after a delay."""
        return self.schedule_at(self.current_time + delay, callback, description, data)
    
    @abstractmethod
    def step(self) -> bool:
        """
        Execute one simulation step.
        Returns True if simulation should continue, False otherwise.
        """
        pass
    
    def run(self, end_time: float = None, max_steps: int = None) -> Dict:
        """
        Run the simulation until end_time or max_steps.
        Returns simulation results.
        """
        self.state = SimulationState.RUNNING
        self.end_time = end_time or float('inf')
        
        steps = 0
        try:
            while self.current_time < self.end_time:
                if max_steps and steps >= max_steps:
                    break
                
                if not self.step():
                    break
                
                steps += 1
                
                # Execute step callbacks
                for callback in self.on_step:
                    callback(self)
            
            self.state = SimulationState.COMPLETED
            
            # Execute completion callbacks
            for callback in self.on_complete:
                callback(self)
                
        except Exception as e:
            self.state = SimulationState.ERROR
            self.log(f"Simulation error: {str(e)}", LogLevel.ERROR)
            
            # Execute error callbacks
            for callback in self.on_error:
                callback(self, e)
            raise
        
        return self.get_results()
    
    def get_results(self) -> Dict:
        """Get simulation results."""
        return {
            "name": self.name,
            "final_time": self.current_time,
            "state": self.state.name,
            "events_processed": self.event_queue._event_counter,
            "collectors": {
                name: collector.to_dict() 
                for name, collector in self.data_collectors.items()
            },
            "logs": self.logs[-100:]  # Last 100 log entries
        }
    
    def reset(self) -> None:
        """Reset the simulation to initial state."""
        self.current_time = 0.0
        self.state = SimulationState.INITIALIZED
        self.event_queue.clear()
        self.logs.clear()
        for collector in self.data_collectors.values():
            collector.data.clear()
        
        if self._seed is not None:
            self.rng = random.Random(self._seed)


# =============================================================================
# Utility Functions
# =============================================================================

def date_to_sim_time(date: datetime, start_date: datetime) -> float:
    """Convert a datetime to simulation time (days from start)."""
    delta = date - start_date
    return delta.total_seconds() / 86400.0  # Convert to days


def sim_time_to_date(sim_time: float, start_date: datetime) -> datetime:
    """Convert simulation time (days) to datetime."""
    return start_date + timedelta(days=sim_time)


def parse_date(date_str: str) -> datetime:
    """Parse a date string in common formats."""
    formats = [
        "%Y-%m-%d",
        "%Y/%m/%d",
        "%d-%m-%Y",
        "%d/%m/%Y",
        "%Y-%m-%dT%H:%M:%S",
    ]
    for fmt in formats:
        try:
            return datetime.strptime(date_str, fmt)
        except ValueError:
            continue
    raise ValueError(f"Unable to parse date: {date_str}")
