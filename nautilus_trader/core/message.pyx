# -------------------------------------------------------------------------------------------------
# <copyright file="message.pyx" company="Nautech Systems Pty Ltd">
#  Copyright (C) 2015-2019 Nautech Systems Pty Ltd. All rights reserved.
#  The use of this source code is governed by the license as found in the LICENSE.md file.
#  https://nautechsystems.io
# </copyright>
# -------------------------------------------------------------------------------------------------

from cpython.datetime cimport datetime

from nautilus_trader.core.types cimport GUID
from nautilus_trader.core.message cimport MessageType


cdef class Message:
    """
    The base class for all messages.
    """

    def __init__(self,
                 MessageType message_type,
                 GUID identifier,
                 datetime timestamp):
        """
        Initializes a new instance of the Message abstract class.

        :param message_type: The message type.
        :param identifier: The message identifier.
        :param timestamp: The message timestamp.
        """
        self.message_type = message_type
        self.id = identifier
        self.timestamp = timestamp

    cdef bint equals(self, Message other):
        """
        Return a value indicating whether this object is equal to (==) the given object.

        :param other: The other object.
        :return bool.
        """
        if self.message_type == other.message_type:
            return self.id == other.id
        else:
            return False

    def __eq__(self, Message other) -> bool:
        """
        Return a value indicating whether this object is equal to (==) the given object.

        :param other: The other object.
        :return bool.
        """
        return self.equals(other)

    def __ne__(self, Message other) -> bool:
        """
        Return a value indicating whether this object is not equal to (!=) the given object.

        :param other: The other object.
        :return bool.
        """
        return not self.equals(other)

    def __hash__(self) -> int:
        """"
        Return a hash representation of this object.

        :return int.
        """
        return hash(self.id)

    def __str__(self) -> str:
        """
        Return a string representation of this object.

        :return str.
        """
        return f"{self.__class__.__name__}({self.id.value})"

    def __repr__(self) -> str:
        """
        Return a string representation of this object which includes the objects
        location in memory.

        :return str.
        """
        return f"<{str(self)} object at {id(self)}>"


cdef class Command(Message):
    """
    The base class for all commands.
    """

    def __init__(self, GUID identifier, datetime timestamp):
        """
        Initializes a new instance of the Command abstract class.

        :param identifier: The command identifier.
        :param timestamp: The command timestamp.
        """
        super().__init__(MessageType.COMMAND, identifier, timestamp)


cdef class Event(Message):
    """
    The base class for all events.
    """

    def __init__(self,
                 GUID identifier,
                 datetime timestamp):
        """
        Initializes a new instance of the Event abstract class.

        :param identifier: The event identifier.
        :param timestamp: The event timestamp.
        """
        super().__init__(MessageType.EVENT, identifier, timestamp)


cdef class Request(Message):
    """
    The base class for all requests.
    """

    def __init__(self, GUID identifier, datetime timestamp):
        """
        Initializes a new instance of the Request abstract class.

        :param identifier: The request identifier.
        :param timestamp: The request timestamp.
        """
        super().__init__(MessageType.REQUEST, identifier, timestamp)


cdef class Response(Message):
    """
    The base class for all responses.
    """

    def __init__(self,
                 GUID correlation_id,
                 GUID identifier,
                 datetime timestamp):
        """
        Initializes a new instance of the Response abstract class.

        :param identifier: The correlation identifier.
        :param identifier: The response identifier.
        :param timestamp: The response timestamp.
        """
        super().__init__(MessageType.RESPONSE, identifier, timestamp)
        self.correlation_id = correlation_id

    def __str__(self) -> str:
        """
        Return a string representation of this object.

        :return str.
        """
        return f"{self.__class__.__name__}(id={self.id.value}, correlation_id={self.id.value})"
